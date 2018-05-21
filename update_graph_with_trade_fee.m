function graph_input = update_graph_with_trade_fee(graph_input, fee)

graph_input.askPrice   = graph_input.askPrice*(1 - fee);
graph_input.askLogRate = -log(graph_input.askPrice);