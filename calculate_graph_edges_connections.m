function graph_ = calculate_graph_edges_connections(graph_, assetsList)

%% calculate graph edges connections u, and v are assets index inside assetsList
for i = 1:length(assetsList)
    graph_.iu(strcmp(graph_.baseAsset, assetsList(i)))    = i;
    graph_.iv(strcmp(graph_.quoteAsset, assetsList(i)))   = i;
end
