extends Panel

var used = false
var segment_size = 0
var base_size = 0

func run_resize(hp, base_hp):
	if (!used):
		calc_segment_size(base_hp)
		used = true
	
	calc_shrinkage(hp)

func calc_segment_size(base_hp):
	base_size = rect_size.x
	segment_size = base_size / base_hp #gives size of what 1 hp point is worth
	
func calc_shrinkage(hp):
	var new_size = segment_size * hp
	rect_size.x = (new_size)

