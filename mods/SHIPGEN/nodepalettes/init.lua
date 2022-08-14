nodepalettes = {}

-- table to hold all nodes to choose palettes for.
nodepalettes.mapgen_nodes = {}

-- 3d noises must have 3d in the name
nodepalettes.nps={
    large3d = {
        offset = 0,
        scale = 1,
        spread = {x = 100, y = 100, z = 100},
        seed = 571347,
        octaves = 3,
        persistence = .7,
        lacunarity = 3.0,
        --flags = "defaults, absvalue",
    },
    small3d = {
        offset = 0,
        scale = 1,
        spread = {x = 10, y = 10, z = 10},
        seed = 571347,
        octaves = 3,
        persistence = .7,
        lacunarity = 3.0,
        --flags = "defaults, absvalue",
    },
    flat3d = {
        offset = 0,
        scale = 1,
        spread = {x = 100, y = 10, z = 100},
        seed = 571347,
        octaves = 3,
        persistence = .7,
        lacunarity = 3.0,
        --flags = "defaults, absvalue",
    },

}


-- takes nodename (string), 
-- noises_used (table of strings (names of noises), 
-- and mix_function, a function that is given a noises table 
    -- that includes the noise values of the noise names in noises_used)
nodepalettes.register_palette_node = function(nodename,noises_used,mix_function,min_index,max_index)
    local mix_function = mix_function or function(noises) 
        return math.remap(noises.large3d, -2.5, 2.5, 1, 254)
    end
    noises_used = noises_used or {"large3d"}
    min_index = min_index or 1
    max_index = max_index or 254
    local cid = minetest.get_content_id(nodename)
    nodepalettes.mapgen_nodes[cid] = {
        noises_used = noises_used,
        name = nodename,
        mix = mix_function,
        min_i = min_index,
        max_i = max_index,
    }
end




minetest.register_on_generated(function(minp, maxp)

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local p_data = vm:get_param2_data()
    local c_data = vm:get_data()

    local sidelen = maxp.x - minp.x + 1
	-- Required dimensions of the 3D noise perlin map.
	local permapdims3d = {x = sidelen, y = sidelen, z = sidelen}

    local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
    local perlin_maps = {}
    for noisename, np in pairs(nodepalettes.nps) do
        local perlin = minetest.get_perlin_map(np,permapdims3d)
        if string.find(noisename,"3d") then
            perlin_maps[noisename] = perlin:get_3d_map_flat(minp)
        else
            perlin_maps[noisename] = perlin:get_2d_map_flat({x=minp.x,y=minp.z})
        end
    end

    local ni = 1
    
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do

            local vi = area:index(minp.x, y, z)
            for x = minp.x, maxp.x do

                local pos = vector.new(x,y,z)

                -- local p_pos = area:index(x, y, z)
                -- local p_pos_2d = area:index(x,0,z)
                local ni_2d = (pos.x - minp.x + 1) + (((pos.z - minp.z)) * sidelen)
                local cid = c_data[vi]
                local def = nodepalettes.mapgen_nodes[cid]
                
                if def then -- if the cid is in the nodepalettes table, we will modify the param2 data
                    local noises = {} -- a table of noise values to pass to the noise mix function
                    for _,noisename in pairs(def.noises_used) do
                        local perlin = perlin_maps[noisename]
                        if string.find(noisename,"3d") then
                            noises[noisename] = perlin_maps[noisename][ni]
                            -- minetest.chat_send_all(string.sub(dump(perlin_maps[noisename]),0,2000))
                        else
                            noises[noisename] = perlin_maps[noisename][ni_2d]
                        end
                    end
                    local p = def.mix(noises) --get param2 from noises here
                    -- minetest.debug(table.concat(noises,"\n"))
                    -- if p == nil then p = 1 end
                    if p > def.max_i then
                        p = def.max_i
                    end
                    if p < def.min_i then
                        p = def.min_i
                    end
                    -- minetest.chat_send_all(def.max_i)
                    p_data[vi] = p

                end

                ni = ni + 1
                vi = vi + 1
            end
        end
    end

    vm:set_param2_data(p_data)
    -- vm:calc_lighting()
    -- vm:update_liquids()
    vm:write_to_map()

end)