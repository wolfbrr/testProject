clear
%% load finance info from binance
[bookTicker, symbolPrice] = loadFinanceData();

[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(bookTicker);
