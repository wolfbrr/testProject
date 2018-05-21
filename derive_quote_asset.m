function derived_data = derive_quote_asset(graph_, asset_name)
%

ind          = cell2mat(cellfun(@(x) strcmp(x, asset_name),  graph_.quoteAsset, 'UniformOutput', false));
derived_data = graph_(ind, :);