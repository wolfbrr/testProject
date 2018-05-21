function [full_assets_graph, bookTicker, symbolPrice, exchangeInfo, assetsList] = loadFinanceData()
% bookTicker     = webread('https://api.binance.com/api/v3/ticker/bookTicker');%?symbol=ETHBTC?symbol=LTCBTC');
% exchangeInfo    = webread('https://api.binance.com//api/v1/exchangeInfo');%?symbol=ETHBTC?symbol=LTCBTC');
% symbolPrice     = webread('https://api.binance.com/api/v3/ticker/price');
load financeData
bookTicker                  = struct2table(bookTicker);
bookTicker.askPrice         = cellfun(@str2num, bookTicker.askPrice);
bookTicker.bidPrice         = cellfun(@str2num, bookTicker.bidPrice);
bookTicker.askLogRate       = -log(bookTicker.askPrice);
bookTicker.bidLogRate       = -log(bookTicker.bidPrice);

%% derive assets list in the market
symbolsInfo                 = struct2table(exchangeInfo.symbols);
sortedAssetsList            = sort([symbolsInfo.baseAsset; symbolsInfo.quoteAsset]);
indecesOfDifferentAssets    = find(~strcmp(sortedAssetsList(1:end-1), sortedAssetsList(2:end)));
assetsList                  = sortedAssetsList([indecesOfDifferentAssets; end]);

symbolsInfo = calculate_graph_edges_connections(symbolsInfo, assetsList);

%% calculate for each index in book ticker connections between assets
for i = 1:height(symbolsInfo)
    ind = find(strcmp(bookTicker.symbol, symbolsInfo.symbol{i}));
    bookTicker.iu(ind) = symbolsInfo.iu(i);
    bookTicker.iv(ind) = symbolsInfo.iv(i);
    bookTicker.baseAsset(ind) = symbolsInfo.baseAsset(i);
    bookTicker.quoteAsset(ind) = symbolsInfo.quoteAsset(i);
    
end

%% calculate connection in opossite direction
full_assets_graph = [bookTicker; calculate_reverse_connection(bookTicker)];
