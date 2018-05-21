function reversed_data = calculate_reverse_connection(assets_graph)
reversed_data             = assets_graph;
reversed_data.quoteAsset  = assets_graph.baseAsset;
reversed_data.baseAsset   = assets_graph.quoteAsset;

reversed_data.symbol      = strcat(assets_graph.quoteAsset, assets_graph.baseAsset);
reversed_data.iu          = assets_graph.iv;
reversed_data.iv          = assets_graph.iu;
reversed_data.askPrice    = 1./assets_graph.bidPrice;
reversed_data.bidPrice    = 1./assets_graph.askPrice;
reversed_data.askLogRate  = -assets_graph.bidLogRate;
reversed_data.bidLogRate  = -assets_graph.askLogRate;
