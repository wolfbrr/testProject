clear
%% load finance info from binance
[assetsGraph, bookTicker, symbolPrice] = loadFinanceData();
[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(assetsGraph);
