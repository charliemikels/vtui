module vtui

// Row takes a list of children and orders them left to right.
// TODO: Use spacing to control distribution
struct Row {
	children []Widget = [EmptyWidget{}]
	spacing  string
	// 'even'			Every child gets the same space
	// 'balanced' Try to prioritize original proportions.
	// other options???
}

pub struct RowConfig {
	spacing string = 'even'
}

pub fn new_row(c RowConfig, children ...Widget) Widget {
	mut children_list := []Widget{}
	for child in children {
		children_list << child
	}
	row := Row {
		// children: children_list
		spacing: c.spacing
	}
	return row
}

fn (r Row) get_target_size() (int, int) {
	mut w, mut h := 0, 0
	for child in r.children {
		current_w, current_h := child.get_target_size()
		w += current_w
		if h < current_h {
			h = current_h
		}
	}
	return w, h
}

fn (r Row) render(w int, h int) [][]string {
	mut rendered_row := [][]string{len: h, init: []string{len: w, init: ' '}}
	mut cell_widths := []int{len: r.children.len}
	match r.spacing {
		'even' {
			base_width := w / r.children.len	// TODO: Possible divide by 0 error here.
			mut remaining_space := w % r.children.len
			for i in 0 .. r.children.len {
				cell_widths[i] += base_width
				if i < remaining_space {
					cell_widths[i]++
				}
			}
		}
		else {
			panic('Bad value for spacing in $r: $r.spacing')
		}
	}
	for i, child in r.children {
		rendered_child := child.render(cell_widths[i], h)
		current_low := match i {
			0 { '0'.int() } // TODO: 0 on it's own is an any_int, incompatable in a match with int (the else). Fix later
			else { sum(cell_widths[0..i]) }
		}
		current_high := sum(cell_widths[0..i + 1])
		for row in 0 .. h {
			for col in current_low .. current_high {
				rendered_row[row][col] = rendered_child[row][col - current_low]
			}
		}
	}
	return rendered_row
}

fn (r Row) to_string() string {
	// return 'Row($r.children.len children)'
	return 'Row'
}
