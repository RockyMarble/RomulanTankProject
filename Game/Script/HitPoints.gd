extends Panel

var used         = false
var segment_size = 0
var base_size    = 0

#used as template for both fuel and hp size updates. 
################################################################################
#if window is resized during game, will show inaccurate bar size for remainder
#of level. will reset next level.
################################################################################

func run_resize(current_val, base_val):
	#for first instance of being called from respective object instance,
	#will run the size gathering functions, 
	#allowing for segment size to be found
	if (!used): 
		calc_segment_size(base_val)
		used = true
	
	calc_shrinkage(current_val) 
	# then runs size adjustment 
func calc_segment_size(base_val): # calcs segment size with base size and max hp,
								#giving size value for 1 unit of variable given.
	base_size = rect_size.x
	segment_size = base_size / base_val #gives size of what 1 hp point is worth
	
func calc_shrinkage(val): #gives new size based on current size 
	var new_size = segment_size * val
	rect_size.x = (new_size)

