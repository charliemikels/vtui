module vtui

// Row takes a list of children and orders them left to right.
// TODO: Use spacing to control distribution
struct Row {
	children []Widget
	spacing  string = 'even'
		// even: Every child gets the same space
		// balanced: Try to prioritize original proportions.
		// other options???
}

pub struct RowConfig {
	// spacing string
}

pub fn new_row(c RowConfig, children_list []Widget) Row {
	row := Row{
		children: children_list
	}
	// println('new_row - original children list len: ${children_list.len}')
	// println('new_row - coppied row list len: ${row.children.len}')
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
	// println(r)
	mut rendered_row := [][]string{len: h, init: []string{len: w, init: ' '}}
	// println('(Width: $w, Height: $h)')
	// println("(${rendered_row[0].len}, ${rendered_row.len})")
	mut cell_widths := []int{len: r.children.len}
	if r.spacing == 'even' {
		base_width := w / r.children.len
		mut remaining_space := w % r.children.len
		// println(w)
		// println('base_width: $base_width')
		// println('remaining_space $remaining_space')
		for i in 0 .. r.children.len {
			// println(r.children[i].render(3,3))
			cell_widths[i] += base_width
			if i < remaining_space {
				cell_widths[i]++
			}
		}
		// println('Cell widths: $cell_widths')
	}
	for i, child in r.children {
		rendered_child := child.render(cell_widths[i], h)
		current_low := match i {
			0 { '0'.int() } // TODO: 0 on it's own is an any_int, incompatable in a match with int (the else). Fix when fixed in V.
			else { sum(cell_widths[0..i]) }
		}
		current_high := sum(cell_widths[0..i + 1])
		// println('Child $i low/high: $current_low, $current_high')
		// println(rendered_child)
		// println('Child $i range: [${offset}, ${cell_widths[i] + offset -1}]')
		for row in 0 .. h {
			for col in current_low .. current_high {
				// println("($row, $col (${col + offset})) -- (${rendered_row.len}, ${rendered_row[0].len}) : ${rendered_row[row][col]}")
				rendered_row[row][col] = rendered_child[row][col - current_low]
			}
		}
		// println(rendered_row)
	}
	return rendered_row
}

fn (r Row) str() string {
	return 'Row($r.children.len children)'
}
