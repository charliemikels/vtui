module v_term_ui

struct Table {
	data              [][]string
	has_header        bool
	// rows_selectable   bool
	// has_borders       bool
	// ideal_col_widths  []int
	// ideal_row_width   int
	// ideal_table_width int
// mut:
// 	selected_ind      int = -1
}

pub struct TableConfig {
	data            [][]string	// [row][col]
	has_header      bool = true
	// rows_selectable bool
	// has_borders     bool
}


pub fn new_table(c TableConfig) &Table {
	t := &Table{
		data: c.data
		has_header: c.has_header
	}
	return t
}

fn (t Table) get_ideal_col_widths() []int {
	mut ideal_col_widths := []int{len: t.data[0].len, init: -1}
	for row in t.data {
		for i, col in row {
			if col.len > ideal_col_widths[i] {
				ideal_col_widths[i] = col.len
			}
		}
	}
	return ideal_col_widths
}

fn sum(a []int) int {
	mut sum := 0
	for num in a {
		sum += num
	}
	return sum
}

fn (t Table) get_target_size() (int, int) {	// width, height
	mut ideal_table_width := sum(t.get_ideal_col_widths()) // Sum col widths
	ideal_table_width += (t.data[0].len-1)  				 // space between every col "│" (but not last col)

	mut ideal_table_height := t.data.len // num rows
	if t.has_header == true { ideal_table_height++ }

	return ideal_table_width, ideal_table_height

}

// fn max_i(a []int) int { // returns the last maximum
// 	mut max_i := 0
// 	for i, n in a {
// 		if n >= a[max_i] {
// 			max_i = i
// 		}
// 	}
// 	return max_i
// }

pub fn (t Table) render(w int, h int) [][]string {
	println('Table data: $t.data')
	println('Table size: ${t.get_target_size()}')

	rendered_table := [][]string{len: h, init: []string{len: w, init:'t'} }


	return rendered_table


}
