nodepalettes = {}

-- table to hold all nodes to choose palettes for.
nodepalettes.mapgen_nodes = {}

-- 3d noises must have 3d in the name
nodepalettes.nps={
    large3d = {
        offset = 0,
        scale = 1,
        spread = {x = 55, y = 55, z = 55},
        seed = 571347,
        octaves = 3,
        persistence = 0.63,
        lacunarity = 2.0,
        --flags = "defaults, absvalue",
    },
}


-- takes nodename (string), 
-- noises_used (table of strings (names of noises), 
-- and mix_function, a function that is given a noises table 
    -- that includes the noise values of the noise names in noises_used)
nodepalettes.register_palette_node = function(nodename,noises_used,mix_function)
    local mix_function = mix_function or function(noises) 
        return math.remap(noises.large3d, -2, 2, 0, 254) 
    end
    noises_used = noises_used or {"large3d"}
    local cid = minetest.get_content_id(nodename)
    nodepalettes.mapgen_nodes[cid] = {
        noises_used = noises_used,
        name = nodename,
        mix = mix_function,        
    }
end




minetest.register_on_generated(function(minp, maxp)

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local p_data = vm:get_param2_data()
    local c_data = vm:get_data()
    local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
    local perlin_maps = {}
    for noisename, np in pairs(nodepalettes.nps) do
        local perlin = minetest.get_perlin_map(np,vector.new(emax.x-emin.x,emax.y-emin.y,emax.z-emin.z))
        if string.find(noisename,"3d") then
            perlin_maps[noisename] = perlin:get_3d_map_flat(emin)
        else
            perlin_maps[noisename] = perlin:get_2d_map_flat({x=emin.x,y=emin.z})
        end
    end

    local p_pos_2d = 0
    for x = minp.x, maxp.x do
        for y = minp.y, maxp.y do
            for z = minp.z, maxp.z do

                local p_pos = area:index(x, y, z)
                local p_pos_2d = area:index(x,0,z)

                local pos = vector.new(x,y,z)
                
                local cid = c_data[p_pos]
                local def = nodepalettes.mapgen_nodes[cid]
                
                if def then -- if the cid is in the nodepalettes table, we will modify the param2 data
                    local noises = {} -- a table of noise values to pass to the noise mix function
                    for _,noisename in pairs(def.noises_used) do
                        local perlin = perlin_maps[noisename]
                        if string.find(noisename,"3d") then
                            noises[noisename] = perlin_maps[noisename][p_pos]
                            -- minetest.chat_send_all(string.sub(dump(perlin_maps[noisename]),0,2000))
                        else
                            noises[noisename] = perlin_maps[noisename][p_pos_2d]
                        end
                    end
                    local p = def.mix(noises) --get param2 from noises here
                    -- minetest.debug(table.concat(noises,"\n"))
                    p_data[p_pos] = p

                end
            end
            p_pos_2d = p_pos_2d + 1
        end
    end

    vm:set_param2_data(p_data)
    -- vm:calc_lighting()
    -- vm:update_liquids()
    vm:write_to_map()

end)