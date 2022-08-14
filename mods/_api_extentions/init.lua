function math.remap(val, min_val, max_val, min_map, max_map)
	return (val-min_val)/(max_val-min_val) * (max_map-min_map) + min_map
end

function math.lerp(var_a, var_b, ratio)
	return (1-ratio)*var_a + (ratio*var_b)
end