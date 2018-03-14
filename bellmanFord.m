function [distance, predecessor, cycleNodes] = bellmanFord()
%Belman-Ford
iu = 1;
iv = 2;
iw = 3;

W = [1, 2, 4;
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

nodesNumber = max(W(:, iu));
edgesNumber = length(W);
predecessor = 0*ones(nodesNumber,1);
distance = inf*ones(nodesNumber, 1);
distance(1) = 0;
cycleNodes          = zeros(nodesNumber, 1);
nodeIndexes     = zeros(nodesNumber, 1);
isCycleNotDefined   = true;
isCycleNotFnd   = true;

for node = 1:nodesNumber-1
    prevDistance = distance;
    for edge = 1:edgesNumber
        u = W(edge, iu);
        v = W(edge, iv);
        w = W(edge, iw);
        [~, distance, predecessor] = relax( u, v, w, distance, prevDistance, predecessor);
    end
end

prevDistance = distance;
for edge = 1:edgesNumber
    u = W(edge, iu);
    v = W(edge, iv);
    w = W(edge, iw);
    [isRelaxed, distance, ~] = relax( u, v, w, distance, prevDistance, predecessor);
    if isRelaxed
        sprintf('negative cycle detection on node %d', v)
        % find first cycle index
        nodeIndexes(v)  = v;
        while isCycleNotFnd
            v               = predecessor(v);
            isCycleNotFnd   = ~nodeIndexes(v);
            nodeIndexes(v)  = v;
        end
        
        cycleNodes(v)       = v; % first cycle node
        while isCycleNotDefined
            v                   = predecessor(v);
            isCycleNotDefined   = ~cycleNodes(v);
            cycleNodes(v)       = v;
        end
        break
    end
end


end

function [isRelaxed, distance, predecessor] = relax(u, v, w, distance, prev_distance, predecessor)
isRelaxed = false;
if ~isinf(prev_distance(u)) && distance(v) > prev_distance(u) + w
    distance(v) = prev_distance(u) + w;
    predecessor(v) = u;
    isRelaxed = true;
end
end