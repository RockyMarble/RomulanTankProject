extends Panel

var used = false
var segment_size = 0
var base_size = 0
#used as template for both fuel and hp size updates. 
func run_resize(current_val, base_val):
	if (!used):
		calc_segment_size(base_val)
		used = true
	
	calc_shrinkage(current_val)

func calc_segment_size(base_val):
	base_size = rect_size.x
	segment_size = base_size / base_val #gives size of what 1 hp point is worth
	
func calc_shrinkage(val):
	var new_size = segment_size * val
	rect_size.x = (new_size)

