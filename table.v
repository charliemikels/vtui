module vtui

import arrays as arr

struct Table {
	data       [][]string
	has_header bool
	// rows_selectable   bool
	// has_borders       bool
	// ideal_col_widths  []int
	// ideal_row_width   int
	// ideal_table_width int
	// mut:
	// selected_ind      int = -1
}

pub struct TableConfig {
	data       [][]string // [row][col]
	has_header bool = true
	// rows_selectable bool
	// has_borders     bool
}

pub fn new_table(c TableConfig) Table {
	t := Table{
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

// string_to_array converts a string into an array of strings, but it also
// respects potential utf8 characters.
// TODO: Set to return []rune] instead of []string
fn string_to_array(s string) []string {
	mut rune_list := []string{}
	mut rune_builder := []byte{}
	mut num_bytes := 0
	// https://stackoverflow.com/a/33349765 - Simple table of utf8 hex ranges
	for ch in s {
		if ch >= 0xC0 && ch <= 0xDF {
			num_bytes = 2
		} else if ch >= 0xE0 && ch <= 0xEF {
			num_bytes = 3
		} else if ch >= 0xF0 && ch <= 0xF7 {
			num_bytes = 4
		}
		if num_bytes > 0 { // we found or are inside of a utf8 character
			rune_builder << ch
			num_bytes--
			if num_bytes == 0 {
				rune_list << rune_builder.bytestr()
				rune_builder = []
			}
		} else {
			rune_list << ch.str()
		}
	}
	// if rune_list.len != utf8.len(s) {
	// mut error_string := 'Error in string_to_array(): Generated array.len != utf8 length'
	// error_string += '\nOriginal string: $s'
	// error_string += '\nGenerated array: $rune_list'
	// error_string += '\nUTF8 len: ${utf8.len(s)}'
	// error_string += '\nArray len: $rune_list.len'
	// panic(error_string)
	// }
	return rune_list
}

fn (t Table) get_target_size() (int, int) { // width, height
	mut ideal_table_width := sum(t.get_ideal_col_widths()) // Sum col widths
	ideal_table_width += (t.data[0].len - 1) // space between every col "│" (but not last col)
	mut ideal_table_height := t.data.len // num rows
	if t.has_header == true {
		ideal_table_height++
	}
	return ideal_table_width, ideal_table_height
}

// calc_col_widths takes the given width of the table and stretches or shrinks
// the columns to fit this total width.
fn (t Table) calc_col_widths(tw int) []int { // table width
	mut building_col_widths := t.get_ideal_col_widths()
	ideal_table_width := sum(building_col_widths) + building_col_widths.len - 1 // sum cols + spacers (last row: no spacer)
	mut dif := ideal_table_width - tw
	// if we need to shrink the table...
	if dif > 0 {
		for _ in 0 .. dif {
			building_col_widths[arr.idx_max(building_col_widths)]--
		}
	}
	// if we need to stretch the table...
	if dif < 0 {
		dif *= -1
		mut current_ind := 0
		for _ in 0 .. dif {
			building_col_widths[current_ind]++
			current_ind++
			if current_ind >= building_col_widths.len {
				current_ind = 0
			}
		}
	}
	return building_col_widths
}

fn (t Table) render(width int, height int) [][]string {
	mut rendered_table := [][]string{len: height, init: []string{len: width, init: ' '}}
	// calculate widths for each column. This dictates the width of the whole table
	column_widths := t.calc_col_widths(width)
	// combine cols in a row into one string
	mut row_strings := []string{len: t.data.len, init: ''}
	for r, row in t.data {
		for c, col in row {
			if col.len < column_widths[c] {
				row_strings[r] += (col + ' '.repeat(column_widths[c] - col.len))
			} else if col.len == column_widths[c] {
				row_strings[r] += (col)
			} else if col.len > column_widths[c] {
				if column_widths[c] > 3 {
					row_strings[r] += (col[0..column_widths[c] - 1] + '…')
				} else {
					row_strings[r] += (col[0..column_widths[c]])
				}
			}
			// sepparators
			if c != row.len - 1 {
				row_strings[r] += '│'
			}
		}
	}
	// Build spacer row if table has a header.
	if t.has_header == true {
		mut header_separator := ''
		for i, w in column_widths {
			header_separator += '─'.repeat(w)
			if i != column_widths.len - 1 {
				header_separator += '┼'
			}
		}
		row_strings.insert(1, header_separator)
	}
	// Add space to bottom if our data is too short to fit render height
	if row_strings.len <= height {
		mut bottom_space := ''
		for i, w in column_widths {
			bottom_space += ' '.repeat(w)
			if i != column_widths.len - 1 {
				bottom_space += '│'
			}
		}
		for _ in row_strings.len .. height {
			row_strings << bottom_space
		}
	}
	// TODO: Add 'rip' to mark if a table is too large to fit in space??
	// Place results in rendered_table
	for r, _ in rendered_table {
		if r >= row_strings.len {
			break
		}
		row_array := string_to_array(row_strings[r])
		for ch, _ in rendered_table[r] {
			rendered_table[r][ch] = row_array[ch].str()
		}
	}
	return rendered_table
}

fn (t Table) str() string {
	return 'Table'
}
