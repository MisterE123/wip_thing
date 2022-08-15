minetest.register_biome({
    name = "grassland",
    node_top = "grass",
    depth_top = 1,
    node_filler = "dirt",
    depth_filler = 3,
    node_riverbed = "sand",
    depth_riverbed = 2,
    node_dungeon = "stone",
    node_dungeon_alt = "stone",
    node_dungeon_stair = "stone",
    y_max = 31000,
    y_min = 4,
    heat_point = 50,
    humidity_point = 35,
})


minetest.register_biome({
    name = "grassland_beach",
    node_top = "sand",
    depth_top = 1,
    node_filler = "sand",
    depth_filler = 3,
    node_riverbed = "sand",
    depth_riverbed = 2,
    node_dungeon = "stone",
    node_dungeon_alt = "stone",
    node_dungeon_stair = "stone",
    y_max = 6,
    y_min = -3,
    heat_point = 50,
    humidity_point = 35,
})
