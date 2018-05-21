%% fee test
clear
dataForTest.symbol = [{'ab'}, {'ba'}]';
dataForTest.askPrice = [1 1]';
dataForTest.askLogRate = -log(dataForTest.askPrice);
dataForTest.bidPrice = [1 1.05]';
dataForTest.bidLogRate = -log(dataForTest.bidPrice);
dataForTest.iu = [1 2]';
dataForTest.iv = [2 1]';
dataForTest = struct2table(dataForTest);

[distance, predecessor, cycleNodes, isCycleNotFnd] = bellmanFord(dataForTest);


dataForTest = update_graph_with_trade_fee(dataForTest, 0.1);
[distance, predecessor, cycleNodes, isCycleNotFnd] = bellmanFord(dataForTest);
