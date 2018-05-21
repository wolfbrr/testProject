function derived_data = derive_base_asset(graph_, asset_name)
%

ind          = cell2mat(cellfun(@(x) strcmp(x, asset_name),  graph_.baseAsset, 'UniformOutput', false));
derived_data = graph_(ind, :);