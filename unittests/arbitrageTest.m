clear
dataForTest.symbol = [{'ab'}, {'bc'}, {'ac'}]';
dataForTest.askPrice = [3.4 6 1/6/3.4]';
dataForTest.askLogRate = -log(dataForTest.askPrice);

dataForTest.bidPrice = [3.4 6 1/6/3.4]'*1.1;
dataForTest.bidLogRate = -log(dataForTest.bidPrice);
dataForTest.iu = [1 2 3]';
dataForTest.iv = [2 3 1]';
dataForTest = struct2table(dataForTest);
[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(dataForTest);

%% example from algorithmique-cycles-2011a.pdf
data_for_test = [1, 2, 4;
    1, 4, 4;
   3, 1, 3;
   3, 4, 2;
    4, 5, -2;
    4, 6, 4;
    5, 2, 3;
    5, 6, -3;
    6, 7, -2;
    6, 3, 1;
    7, 5, 2;
    7, 8, 2;
    8, 6, -2];

data_for_test = array2table(data_for_test, 'VariableNames',{'iu','iv','bidLogRate'});
[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(data_for_test);

assert(isequal(cycleNodes,[0;0;0;0;5;6;7;0]), 'wrong NC detected')
%% fee test
clear
dataForTest.symbol = [{'ab'}, {'ba'}]';
dataForTest.askPrice = [1 1.05]';
dataForTest.askLogRate = -log(dataForTest.askPrice);

dataForTest.bidPrice = [1.05 1]';
dataForTest.bidLogRate = -log(dataForTest.bidPrice);
dataForTest.iu = [1 2]';
dataForTest.iv = [2 1]';
dataForTest = struct2table(dataForTest);

[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(dataForTest);


dataForTest = update_graph_with_trade_fee(dataForTest, 0.5);
[distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(dataForTest);
