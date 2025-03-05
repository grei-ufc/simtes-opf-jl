function init_model!(m::JuMP.Model, case_data::Dict, case_config_data::Dict)

    grid_data = deepcopy(case_data)
    config_data = deepcopy(case_config_data)
    
    pv_nodes = keys(config_data["devices"]["stochastic_gen"]["params"])
    shiftable_load_nodes = (
        keys(config_data["devices"]["shiftable_load"]["params"]))
    buffering_devices_nodes = (
        keys(config_data["devices"]["buffering_device"]["params"]))
    freely_control_gen_nodes = (
        keys(config_data["devices"]["freely_control_gen"]["params"]))
    user_action_device_nodes = (
        keys(config_data["devices"]["user_action_device"]["params"]))
    dso_storage_device_nodes = (
        keys(config_data["devices"]["dso_storage_device"]["params"]))
    storage_device_nodes = (
        keys(config_data["devices"]["storage_device"]["params"]))
    lv_nodes = config_data["nodes_lv"]
    mv_nodes = config_data["nodes_mv"]

    ##### SETS
    m.ext[:sets] = Dict()

    # All nodes
    M = m.ext[:sets][:node] = (
        [string(node["id"])
        for node in grid_data["nodes"]])
    
    # PV nodes
    MPV = m.ext[:sets][:node_pv] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in pv_nodes])
    
    # Shiftable load nodes
    MSL = m.ext[:sets][:node_sl] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in shiftable_load_nodes])

    # buffering devices nodes
    MBD = m.ext[:sets][:node_bd] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in buffering_devices_nodes])

    # Freely control gen nodes
    MFCG = m.ext[:sets][:node_fcg] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in freely_control_gen_nodes])

    # User Action Device nodes
    MUA = m.ext[:sets][:node_ua] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in user_action_device_nodes])

    # DSO Storage Device nodes
    MOSD = m.ext[:sets][:node_osd] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in dso_storage_device_nodes])

    # Storage Device nodes
    MSD = m.ext[:sets][:node_sd] = (
        [string(node["id"])
        for node in grid_data["nodes"]
            if string(node["id"]) in storage_device_nodes])

    return m
end