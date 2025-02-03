module LoadData

using DataFrames
using CSV

export get_load_data, get_gen_data

GRID_DATA_PATH = "1-MVLV-urban-5.303-1-no_sw"
DAYS = 30


"""
    get_load_data(load_index::Union{Nothing, Int} = nothing)
Seleciona um perfil e lê o perfil de carga referente ao perfil selecionado.

### Input

- `load_index` -- (optional, default: nothing) caso um valor seja passado
                  o perfil selecionado será daquele indice, caso contrario
                  será selecionado um pefil aleatório.

### Output

Dataframe com o perfil de carga ativa e reativa.
"""
function get_load_data(load_index::Union{Nothing, Int} = nothing)
    load_df = CSV.read(joinpath(GRID_DATA_PATH, "Load.csv"), DataFrame, delim=";")[139:243, :]
    load_profile_df = CSV.read(joinpath(GRID_DATA_PATH, "LoadProfile.csv"), DataFrame, delim=";")

    month_delta = 24 * 4 * 30 * 1

    if load_index !== nothing
        load = load_df[load_index % 100 + 1, :]
        start_day = 15 * 24 * 4 + month_delta
    else
        load_index = rand(1:size(load_df)[2])
        load = load_df[load_index, :]
        start_day = rand(0:30) * 24 * 4 + month_delta
    end

    end_day = start_day + 30 * 24 * 4

    load_p_data = load_profile_df[:, string(load.profile, "_pload")][start_day:end_day]
    load_q_data = load_profile_df[:, string(load.profile, "_qload")][start_day:end_day]

    load_p_data = load_p_data[1:(24 * 4 * DAYS)]
    load_q_data = load_q_data[1:(24 * 4 * DAYS)]

    load_df = Dict("pload" => load_p_data, "qload"=> load_q_data)
    load_df = DataFrame(load_df)

    return load_df

end



"""
    get_gen_data(load_index::Union{Nothing, Int} = nothing)
Seleciona um perfil e lê o perfil de geração referente ao perfil selecionado.

### Input

- `gen_index` -- (optional, default: nothing) caso um valor seja passado
                  o perfil selecionado será daquele indice, caso contrario
                  será selecionado um pefil aleatório.

### Output

Dataframe com o perfil de carga ativa e reativa.
"""
function get_gen_data(gen_index::Union{Nothing, Int} = nothing)
    gen_df = CSV.read(joinpath(GRID_DATA_PATH, "RES.csv"), DataFrame, delim=";")[135:147, :]
    gen_profile_df = CSV.read(joinpath(GRID_DATA_PATH, "RESProfile.csv"), DataFrame, delim=";")

    month_delta = 24 * 4 * 30 * 1

    if gen_index !== nothing
        gen = gen_df[gen_index % 12 + 1, :]
        start_day = 15 * 24 * 4 + month_delta
    else
        gen_index = rand(1:size(gen_df)[2])
        gen = gen_df[gen_index, :]
        start_day = rand(0:30) * 24 * 4 + month_delta
    end

    end_day = start_day + 30 * 24 * 4
    
    gen_p_data = gen_profile_df[start_day:end_day, gen.profile]
    gen_p_data = (gen_p_data[1:(24 * 4 * DAYS)])

    gens_df = Dict("pgen" => gen_p_data)
    gens_df = DataFrame(gens_df)

end

end
