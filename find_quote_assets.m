function quote_assets_graph = find_quote_assets(assets_graph)

%% BTC-USDT-ETH network calculation

quote_assets_graph = [derive_base_asset(assets_graph, 'USDT');
    derive_base_asset(assets_graph, 'ETH');
    derive_base_asset(assets_graph, 'BTC');
    derive_base_asset(assets_graph, 'BNB')];

assetsList = [{'USDT'}, {'BTC'}, {'ETH'}, {'BNB'}];

quote_assets_graph = calculate_graph_edges_connections(quote_assets_graph, assetsList);

%% calculate connection in opossite direction
quote_assets_graph = [quote_assets_graph; calculate_reverse_connection(quote_assets_graph)];

