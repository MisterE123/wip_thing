minetest.register_node('base_aliases:stone', {
    description = 'Stone\nCold and Hard',
    tiles = { 'pix_o.png' },
	paramtype2 = "color",
	palette = "bluestone_palette.png",
    groups = { cracky = 10 },
    is_ground_content = true
})
nodepalettes.register_palette_node("base_aliases:stone")

minetest.register_node("base_aliases:water", {
	description = "Water\nCold and Wet",
	drawtype = "liquid",
	tiles = {
		{
			name = "pix_pt3.png",
			backface_culling = false,
		},
		{
			name = "pix_pt3.png",
			backface_culling = true,
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "color",
	palette = "water_palette.png",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_aliases:water_flowing",
	liquid_alternative_source = "base_aliases:water",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	-- sounds = default.node_sound_water_defaults(),
})

minetest.register_node("base_aliases:water_flowing", {
	description = "Flowing Water\nCold and Wet",
	drawtype = "liquid",
	tiles = {
		{
			name = "pix_pt3.png",
			backface_culling = false,
		},
		{
			name = "pix_pt3.png",
			backface_culling = true,
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "color",
	palette = "water_palette.png",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_aliases:water_flowing",
	liquid_alternative_source = "base_aliases:water",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	-- sounds = default.node_sound_water_defaults(),
})




minetest.register_node("base_aliases:riverwater", {
	description = "River Water\nBrisk and Cool",
	drawtype = "liquid",
	tiles = {
		{
			name = "pix_pt3.png",
			backface_culling = false,
		},
		{
			name = "pix_pt3.png",
			backface_culling = true,
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "color",
	palette = "water_palette.png",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_aliases:riverwater_flowing",
	liquid_alternative_source = "base_aliases:riverwater",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	-- sounds = default.node_sound_water_defaults(),
})

minetest.register_node("base_aliases:riverwater_flowing", {
	description = "Flowing Riverwater\nBrisk and Cool",
	drawtype = "liquid",
	tiles = {
		{
			name = "pix_pt3.png",
			backface_culling = false,
		},
		{
			name = "pix_pt3.png",
			backface_culling = true,
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "color",
	palette = "water_palette.png",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "base_aliases:riverwater_flowing",
	liquid_alternative_source = "base_aliases:riverwater",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	-- sounds = default.node_sound_water_defaults(),
})


minetest.register_alias('stone', 'base_aliases:stone')
minetest.register_alias('water', 'base_aliases:water')
minetest.register_alias('flowing_water', 'base_aliases:water_flowing')
minetest.register_alias('riverwater', 'base_aliases:riverwater')
minetest.register_alias('flowing_riverwater', 'base_aliases:riverwater_flowing')


minetest.register_alias('mapgen_stone', 'base_aliases:stone')
minetest.register_alias('mapgen_water_source', 'base_aliases:water')
minetest.register_alias('mapgen_river_water_source', 'base_aliases:riverwater')

