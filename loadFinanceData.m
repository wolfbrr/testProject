function [assetsGraph, bookTicker, symbolPrice] = loadFinanceData()
bookTicker     = webread('https://api.binance.com/api/v3/ticker/bookTicker');%?symbol=ETHBTC?symbol=LTCBTC');
bookTicker                  = struct2table(bookTicker);
bookTicker.askPrice         = cellfun(@str2num, bookTicker.askPrice);
bookTicker.bidPrice         = cellfun(@str2num, bookTicker.bidPrice);
bookTicker.askLogRate       = -log(bookTicker.askPrice);
bookTicker.bidLogRate       = -log(bookTicker.bidPrice);
exchangeInfo    = webread('https://api.binance.com//api/v1/exchangeInfo');%?symbol=ETHBTC?symbol=LTCBTC');
symbolPrice     = webread('https://api.binance.com/api/v3/ticker/price');

%% derive assets list in the market
symbolsInfo                 = struct2table(exchangeInfo.symbols);
sortedAssetsList            = sort([symbolsInfo.baseAsset; symbolsInfo.quoteAsset]);
indecesOfDifferentAssets    = find(~strcmp(sortedAssetsList(1:end-1), sortedAssetsList(2:end)));
assetsList                  = sortedAssetsList([indecesOfDifferentAssets; end]);

%% calculate graph edges connections u, and v are assets index inside assetsList
for i = 1:length(assetsList)
    symbolsInfo.iu(strcmp(symbolsInfo.baseAsset, assetsList(i)))    = i;
    symbolsInfo.iv(strcmp(symbolsInfo.quoteAsset, assetsList(i)))   = i;
end

%% calculate for each index in book ticker connections between assets
for i = 1:height(symbolsInfo)
    ind = find(strcmp(bookTicker.symbol, symbolsInfo.symbol{i}));
    bookTicker.iu(ind) = symbolsInfo.iu(i);
    bookTicker.iv(ind) = symbolsInfo.iv(i);
end

%% calculate connection in opossite direction
bookTicker2             = bookTicker;
bookTicker2.iu          = bookTicker.iv;
bookTicker2.iv          = bookTicker.iu;
bookTicker2.iv          = bookTicker.iu;
bookTicker2.iv          = bookTicker.iu;
bookTicker2.askPrice    = bookTicker.bidPrice;
bookTicker2.bidPrice    = bookTicker.askPrice;
bookTicker2.askLogRate  = bookTicker.bidLogRate;
bookTicker2.bidLogRate  = bookTicker.askLogRate;
assetsGraph = [bookTicker;bookTicker2]
