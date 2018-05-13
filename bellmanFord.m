function [distanceToPredecessor, nodePredecessor, negativeCycleNodes, isCycleNotFnd] = bellmanFord(weightedGraph)

numberOfNodes            = max(weightedGraph.iu);
numberOfEdges            = height(weightedGraph);
nodePredecessor          = zeros(numberOfNodes,1);
nodeIndex                = zeros(numberOfNodes, 1);
distanceToPredecessor    = inf(numberOfNodes, 1);
distanceToPredecessor(1) = 0;
nodePredecessor(1)       = 1;
negativeCycleNodes       = zeros(numberOfNodes, 1);
isCycleNotDefined        = true;
isCycleNotFnd            = true;

u = weightedGraph.iu;
v = weightedGraph.iv;
w = weightedGraph.bidLogRate;
%% first run of BF
for node = 1:numberOfNodes-1
    prevDistance = distanceToPredecessor;
    for edge = 1:numberOfEdges
        
        [~, distanceToPredecessor, nodePredecessor] = relax( u(edge), v(edge), w(edge), distanceToPredecessor, prevDistance, nodePredecessor);
    end
end

%% one more run of BF to see if there is a condition for NC
prevDistance = distanceToPredecessor;
for edge = 1:numberOfEdges
    [isRelaxed, distanceToPredecessor, nodePredecessor] = relax( u(edge), v(edge), w(edge), distanceToPredecessor, prevDistance, nodePredecessor);
    
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

