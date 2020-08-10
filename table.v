module v_term_ui

import term

struct Table {
	x int
	y int
	w int
	h int
	data [][]string
	has_header bool
	rows_selectable bool
	has_borders bool
	ideal_col_widths	[]int
	ideal_row_width		int
	ideal_table_width int
}

pub struct TableConfig {
	data [][]string
	x int
	y int
	w int 								= 0
	h int
	has_header bool				= true
	rows_selectable bool	= false
	has_borders bool			= true
}

pub fn table( c TableConfig ) &Table {
	// calculate ideal_column_widths
	mut ideal_col_widths := []int{ len: c.data[0].len, init: -1 }
	for row in c.data {
		for i, col in row {
			if col.len > ideal_col_widths[i] {	ideal_col_widths[i] = col.len }
		}
	}

	// ideal_table_width
	mut ideal_table_width := sum(ideal_col_widths) 		// add col widths
	ideal_table_width += ( ideal_col_widths.len * 3 )	// space between cols " │ "
	ideal_row_width := ideal_table_width
	if c.has_borders { ideal_table_width += 4 }				// space for has_borders "│ " and " │"

	// move data
	t := &Table {
		x: c.x
		y: c.y
		w: c.w
		h: c.h
		data: c.data
		has_header: c.has_header
		rows_selectable: c.rows_selectable
		has_borders: c.has_borders
		ideal_col_widths: ideal_col_widths
		ideal_row_width: ideal_row_width
		ideal_table_width: ideal_table_width

	}
	return t
}

fn sum( a []int) int {
	mut sum := 0
	for num in a { sum += num	}
	return sum
}

fn max_i( a []int) int {	// returns the last maximum
	mut max_i := 0
	for i, n in a {
		if n >= a[max_i] { max_i = i }
	}
	return max_i
}

pub fn (t Table) render_to_text() []string {
	// find ideal width of each col for space padding
	// mut ideal_col_widths := t.get_ideal_column_widths()

	// Truncate or streach rows to fit width
	// Find ideal width of table
	// mut ideal_table_width := 0

	// ideal_table_width += sum(t.ideal_col_widths) 				// add col widths
	// ideal_table_width += ( t.ideal_col_widths.len * 3 )	// space between cols " │ "
	// t.ideal_row_width := ideal_table_width
	// if t.has_borders { ideal_table_width += 4 }		// space for has_borders "│ " and " │"

	// Fit ideal width to actual width
	mut target_col_width := []int{}
	if t.w == 0 || t.w == t.ideal_table_width {
		target_col_width = t.ideal_col_widths
	}
	else if t.w > t.ideal_table_width {
		// Stretches largest column even further to fit t.w
		target_col_width = t.ideal_col_widths
		target_col_width[max_i(target_col_width)] += (t.w - t.ideal_row_width)
	}
	else if t.w < t.ideal_table_width {
		// shrink largest cols first (right to left)
		mut shrinking_columns := t.ideal_col_widths
		mut difference := (t.ideal_row_width - t.w) +1
		for difference > 0 {	// evenly shrinks table as maximum changes
			shrinking_columns[max_i(shrinking_columns)]--
			difference--
		}

		target_col_width = shrinking_columns
	}

	// Textify rows
	mut text_table := []string{ init: '' }
	for r, row in t.data {
		text_table << ''
		for c, col in row {
			// apply target_col_width
			// same width? do nothing
			if col.len == target_col_width[c] { text_table[r] += col }

			// smaller? add spaces	// TODO: left, right, center alingment
			else if col.len < target_col_width[c] {
				text_table[r] += col + ' '.repeat(target_col_width[c] - col.len)
			}

			// Larger? truncate!
			else if col.len > target_col_width[c] {
				if 			target_col_width[c] <= 3 {
					text_table[r] += col.limit(target_col_width[c])
				}
				else if target_col_width[c] <= 9 {
					text_table[r] += col.limit(target_col_width[c] - 1 ) + '-'
				}
				else {
					text_table[r] += col.limit(target_col_width[c] - 3 ) + '...'
				}
			}

			// col spacer. Don't place on last col
			if c < row.len -1 { text_table[r] += ' │ ' }
		}
	}

	// add a border
	if t.has_borders {
		// rows
		for r, row in text_table {
			text_table[r] = '│ ' + row + ' │'
		}
		// top
		mut border_string := '┌─'
		for c, col_w in target_col_width {
			border_string += '─'.repeat(col_w)
			if c < target_col_width.len -1 { border_string += '───' }
		}
		border_string += '─┐'
		text_table.insert(0,border_string)

		// bottom
		border_string = '└─'
		for c, col_w in target_col_width {
			border_string += '─'.repeat(col_w)
			if c < target_col_width.len -1 { border_string += '───' }
		}
		border_string += '─┘'
		text_table << border_string
	}

	// add a header
	if t.has_header {
		mut header_string := ''
		for c, col_w in target_col_width {
			header_string += '─'.repeat(col_w)
			if c < target_col_width.len -1 { header_string += '─┼─' }
		}
		if t.has_borders {
			header_string = '│─' + header_string + '─│'
			text_table.insert(2,header_string)
		}
		else { text_table.insert(1,header_string) }
	}

	return text_table
}

pub fn (t Table) draw() {	// TODO: make respect H
	text_table := t.render_to_text()
	for i, line in text_table {
		term.set_cursor_position(t.x ,t.y + i)
		print(line)
	}
}
