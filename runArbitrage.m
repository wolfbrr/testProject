%% load finance info from binance
clear;clc
[assets_graph, bookTicker, symbolPrice, exchangeInfo, assetsList] = loadFinanceData();

quote_assets_graph = find_quote_assets(bookTicker);%% derive USDT BTC BNB ETH
quote_assets_graph = update_graph_with_trade_fee(quote_assets_graph, 0.0005);

[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(quote_assets_graph);

%% example of LTC and base assets graph calculation
ltc_graph = [derive_base_asset(assets_graph, 'LTC') ;derive_quote_asset(assets_graph, 'LTC');quote_assets_graph];
ltc_graph = calculate_graph_edges_connections(ltc_graph, [{'USDT'}, {'BTC'}, {'ETH'}, {'BNB'}, {'LTC'}]);

[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(ltc_graph);
