function [distanceToPredecessor, nodePredecessor, negativeCycleNodes, isCycleNotFnd] = bellmanFord(weightedGraph)

numberOfNodes            = max(weightedGraph.iu);
numberOfEdges            = height(weightedGraph);
nodePredecessor          = zeros(numberOfNodes,1);
nodeIndex                = zeros(numberOfNodes, 1);
distanceToPredecessor    = inf(numberOfNodes, 1);
distanceToPredecessor(1) = 0;
negativeCycleNodes       = zeros(numberOfNodes, 1);
isCycleNotDefined        = true;
isCycleNotFnd            = true;

%% first run of BF
for node = 1:numberOfNodes-1
    prevDistance = distanceToPredecessor;
    for edge = 1:numberOfEdges
        u = weightedGraph.iu(edge);
        v = weightedGraph.iv(edge);
        w = weightedGraph.askLogRate(edge);
        [~, distanceToPredecessor, nodePredecessor] = relax( u, v, w, distanceToPredecessor, prevDistance, nodePredecessor);
    end
end

%% one more run of BF to see if there is a condition for NC
prevDistance = distanceToPredecessor;
for edge = 1:numberOfEdges
    u = weightedGraph.iu(edge);
    v = weightedGraph.iv(edge);
    w = weightedGraph.askLogRate(edge);
    [isRelaxed, distanceToPredecessor, ~] = relax( u, v, w, distanceToPredecessor, prevDistance, nodePredecessor);
    if isRelaxed
        sprintf('negative cycle detection on node %d', v)
        % find first cycle index
        nodeIndex(v)  = v;
        while isCycleNotFnd
            v               = nodePredecessor(v);
            isCycleNotFnd   = ~nodeIndex(v);
            nodeIndex(v)  = v;
        end
        
        negativeCycleNodes(v)       = v; % first cycle node
        while isCycleNotDefined
            v                   = nodePredecessor(v);
            isCycleNotDefined   = ~negativeCycleNodes(v);
            negativeCycleNodes(v)       = v;
        end
        break
    end
end


end

