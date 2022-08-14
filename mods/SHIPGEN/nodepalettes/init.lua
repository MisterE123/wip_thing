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
                
                local cid = c_data[p_pos]
                local def = nodepalettes.mapgen_nodes[cid]
                if def then -- if the cid is in the nodepalettes table, we will modify the 
                    -- param2 data
                    
                    local p = math.random(0,254) --get param2 from noises here

                    p_data[p_pos] = p

                end
            end
        end
    end

    vm:set_param2_data(p_data)
    -- vm:calc_lighting()
    -- vm:update_liquids()
    vm:write_to_map()

end)