nodepalettes = {}

-- table to hold all nodes to choose palettes for.
nodepalettes.mapgen_nodes = {}




nodepalettes.register_palette_node = function(nodename,mix_function)
    local mix_function = mix_function or function(noises) 
        return noises.large3d
    end
    local cid = minetest.get_content_id(nodename)
    nodepalettes.mapgen_nodes[cid] = {
        name = nodename,
        mix = mix_function,        
    }
end




minetest.register_on_generated(function(minp, maxp)

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local p_data = vm:get_param2_data()
    local c_data = vm:get_data()
    local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})


    for x = minp.x, maxp.x do
        for y = minp.y, maxp.y do
            for z = minp.z, maxp.z do
                local p_pos = area:index(x, y, z)

                local pos = vector.new(x,y,z)
                
                for cid, def in pairs(nodepalettes.mapgen_nodes) do
                    if c_data[p_pos] == cid then
                        -- set the param2 based on noises defined in the lerp function
                        p_data[p_pos] = math.random(0,254)
                    end
                end

            end
        end
    end

    vm:set_param2_data(p_data)
    -- vm:calc_lighting()
    -- vm:update_liquids()
    vm:write_to_map()

end)