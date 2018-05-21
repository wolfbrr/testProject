function [distanceToPredecessor, nodePredecessor, negativeCycleNodes, continue_detect_node] = bellmanFord(weightedGraph)

numberOfNodes            = max(weightedGraph.iu);
numberOfEdges            = height(weightedGraph);
nodePredecessor          = zeros(numberOfNodes,1);
nodeIndex                = zeros(numberOfNodes, 1);
distanceToPredecessor    = inf(numberOfNodes, 1);
distanceToPredecessor(1) = 0;
nodePredecessor(1)       = 1;
negativeCycleNodes       = zeros(numberOfNodes, 1);
isCycleNotDefined        = true;
continue_detect_node            = true;

%% first run of BF
for node = 1:numberOfNodes-1
    prevDistance = distanceToPredecessor;

    for edge = 1:numberOfEdges
        [~, distanceToPredecessor, nodePredecessor] = relax( weightedGraph.iu(edge), weightedGraph.iv(edge), weightedGraph.bidLogRate(edge), distanceToPredecessor, prevDistance, nodePredecessor);
    end
    
end

%% one more run of BF to see if there is a condition for NC
prevDistance = distanceToPredecessor;
for edge = 1:numberOfEdges
    [isRelaxed, distanceToPredecessor, nodePredecessor] = relax( weightedGraph.iu(edge), weightedGraph.iv(edge), weightedGraph.bidLogRate(edge), distanceToPredecessor, prevDistance, nodePredecessor);

    if isRelaxed
        sprintf('negative cycle is detected on node %d', weightedGraph.iv(edge))
        % find first cycle index
        v =  weightedGraph.iv(edge);
        nodeIndex(v)  = v;
        %% going back from detected node to node zero to detect twice passed node which will be on NC
        while continue_detect_node
            v               = nodePredecessor(v);
            continue_detect_node   = ~nodeIndex(v);%% still zero
            nodeIndex(v)  = v;
        end
        first_node_on_cylce = v;
        negativeCycleNodes(first_node_on_cylce)       = first_node_on_cylce; % first cycle node
        while isCycleNotDefined
            v                   = nodePredecessor(v);
            isCycleNotDefined   = ~negativeCycleNodes(v);
            negativeCycleNodes(v)       = v;
        end
        break
    end
end


end

