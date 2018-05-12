function [isRelaxed, distance, predecessor] = relax(u, v, w, distance, prev_distance, predecessor)
isRelaxed = false;
if ~isinf(prev_distance(u)) && distance(v) > prev_distance(u) + w
    distance(v) = prev_distance(u) + w;
    predecessor(v) = u;
    isRelaxed = true;
end
end