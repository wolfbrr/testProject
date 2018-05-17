function [distance, predecessor, cycleNodes, isCycleNotFnd] = findArbitrage(bookTicker)
%% find if there is an NC

[distance, predecessor, cycleNodes, isCycleNotFnd] = bellmanFord(bookTicker);

%% if no NC was found -  substitute ask log rate with bid log rate for each connection
if isCycleNotFnd
    for i = 1:height(bookTicker)
        bookTicker2 = bookTicker;% each substitution is independend from previous
        bookTicker2.bidLogRate(i) = bookTicker2.askLogRate(i);
        [distance, predecessor, cycleNodes, isCycleNotFnd2] = bellmanFord(bookTicker2);
        if ~isCycleNotFnd2
            disp('arbitrage opportunity is found');
        end
    end
end