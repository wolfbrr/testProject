function [distanceToPredecessor, nodePredecessor, cycleNodes, isCycleNotFnd] = bellmanFord(weightedGraph)
%Belman-Ford
iu      = 1;
iv      = 2;
iSell   = 4;
iBuy    = 3;

nodesNumber              = max(weightedGraph.iu);
edgesNumber              = height(weightedGraph);
nodePredecessor          = 0*ones(nodesNumber,1);
distanceToPredecessor    = inf*ones(nodesNumber, 1);
distanceToPredecessor(1) = 0;
cycleNodes               = zeros(nodesNumber, 1);
nodeIndexes              = zeros(nodesNumber, 1);
isCycleNotDefined        = true;
isCycleNotFnd            = true;

for node = 1:nodesNumber-1
    prevDistance = distanceToPredecessor;
    for edge = 1:edgesNumber
        u = weightedGraph.iu(edge);
        v = weightedGraph.iv(edge);
        w = weightedGraph.askPrice(edge);
        [~, distanceToPredecessor, nodePredecessor] = relax( u, v, w, distanceToPredecessor, prevDistance, nodePredecessor);
    end
end

prevDistance = distanceToPredecessor;
for edge = 1:edgesNumber
    u = weightedGraph.iu(edge);
    v = weightedGraph.iv(edge);
    w = weightedGraph.askPrice(edge);
    [isRelaxed, distanceToPredecessor, ~] = relax( u, v, w, distanceToPredecessor, prevDistance, nodePredecessor);
    if isRelaxed
        sprintf('negative cycle detection on node %d', v)
        % find first cycle index
        nodeIndexes(v)  = v;
        while isCycleNotFnd
            v               = nodePredecessor(v);
            isCycleNotFnd   = ~nodeIndexes(v);
            nodeIndexes(v)  = v;
        end
        
        cycleNodes(v)       = v; % first cycle node
        while isCycleNotDefined
            v                   = nodePredecessor(v);
            isCycleNotDefined   = ~cycleNodes(v);
            cycleNodes(v)       = v;
        end
        break
    end
end


end

