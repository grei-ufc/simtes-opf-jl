using Dates
using JSON
using SimtesOPF
using Statistics
using Ipopt
using PowerModelsDistribution

const PMD = PowerModelsDistribution
const JP = JuMP

include("init_model.jl")

load_data_path = "1-MVLV-urban-5.303-1-no_sw"
grid_data_path = "redes/force-red-2.json"
config_path = "redes/config-red-2.json"

grid_data = JSON.parsefile(grid_data_path)
config_data = JSON.parsefile(config_path)

m_opf = JP.Model(Ipopt.Optimizer) 

init_model!(m_opf, grid_data, config_data)
