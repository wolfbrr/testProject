clear
bookTicker     = webread('https://api.binance.com/api/v3/ticker/bookTicker');%?symbol=ETHBTC?symbol=LTCBTC');
exchangeInfo    = webread('https://api.binance.com//api/v1/exchangeInfo');%?symbol=ETHBTC?symbol=LTCBTC');
symbolPrice     = webread('https://api.binance.com/api/v3/ticker/price');
symbols         = exchangeInfo.symbols;
bookTicker      = struct2table(bookTicker);
symbols         = struct2table(symbols);
baseAssets          = symbols.baseAsset;
baseAssets          = sort(baseAssets);
quoteAsset          = sort(symbols.quoteAsset);
symbolsList         = sort([quoteAsset; baseAssets]);
indSymbolList = find(~strcmp(symbolsList(1:end-1), symbolsList(2:end)));
symbolsList = symbolsList([indSymbolList; end]);

for i = 1:length(symbolsList)
    symbols.iu(strcmp(symbols.baseAsset, symbolsList(i))) = i;
    symbols.iv(strcmp(symbols.quoteAsset, symbolsList(i))) = i;
end

for i = 1:height(symbols)
    ind = find(strcmp(bookTicker.symbol, symbols.symbol{i}));
    bookTicker.iu(ind) = symbols.iu(i);
    bookTicker.iv(ind) = symbols.iv(i);
end
bookTicker.askPrice = cellfun(@str2num, bookTicker.askPrice);
bookTicker.bidPrice = cellfun(@str2num, bookTicker.bidPrice);

[distance, predecessor, cycleNodes, isCycleNotFnd] = bellmanFord(bookTicker);

if isCycleNotFnd
    for i = 1:height(bookTicker)
        bookTicker2 = bookTicker;
        bookTicker2.askPrice(i) = (bookTicker2.bidPrice(i) + bookTicker2.askPrice(i))/2;
        [distance, predecessor, cycleNodes, isCycleNotFnd2] = bellmanFord(bookTicker2);
        if ~isCycleNotFnd2
            disp('!');
        end
    end
end