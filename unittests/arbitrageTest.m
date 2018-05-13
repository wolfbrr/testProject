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
