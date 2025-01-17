using JSON
using Dates

GRID_DATA = JSON.parsefile("redes/force-red-2.json")
CONFIG_DATA = JSON.parsefile("redes/config-red-2.json")

times_ = collect(Time(0):Minute(15):Time(23, 45))

mv_nodes_qtd = 7
tx_bess_prosumers = 0.3
tx_bess_dso 0.4