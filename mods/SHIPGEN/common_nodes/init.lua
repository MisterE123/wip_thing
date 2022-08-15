
-- sand

minetest.register_node("common_nodes:sand", {
	description = "Sand\nLoose and Crumbly",
	tiles = { 'pix_o.png' },
	paramtype2 = "color",
	color = "#958357",
	palette = "sand1_palette.png",
	groups = {crumbly = 8, falling_node = 1, sand = 1},
})


nodepalettes.register_palette_node("common_nodes:sand",{"flat3d"},function(noises) 
	return math.remap(noises.flat3d, -2, 2, 1, 254) 
end)

minetest.register_alias('sand', 'common_nodes:sand')
minetest.register_alias('mapgen_sand', 'common_nodes:sand')



-- dirt


minetest.register_node("common_nodes:dirt", {
	description = "dirt\nSoft and Loamy",
	tiles = { 'pix_o.png' },
	paramtype2 = "color",
	color = "#39231e",
	palette = "dirt_palette.png",
	groups = {crumbly = 8, falling_node = 1, dirt = 1},
})


nodepalettes.register_palette_node("common_nodes:dirt",{"small3d"},function(noises) 
	return math.remap(noises.small3d, -2, 2, 1, 254) 
end)

minetest.register_alias('dirt', 'common_nodes:dirt')


-- grass


minetest.register_node("common_nodes:grass", {
	description = "grass\nSpringy and Thickly Matted",
	tiles = { 'pix_o.png' },
	paramtype2 = "color",
	color = "#1a5420",
	palette = "grass_palette.png",
	groups = {crumbly = 8, falling_node = 1, dirt = 1},
})


nodepalettes.register_palette_node("common_nodes:grass",{"small3d"},function(noises) 
	return math.remap(noises.small3d, -2, 2, 1, 254) 
end)

minetest.register_alias('grass', 'common_nodes:grass')
