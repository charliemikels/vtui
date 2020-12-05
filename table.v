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

// string_to_array converts a string into an array of strings, but it also
// respects potential utf8 characters.
// TODO: Set to return []rune] instead of []string
fn string_to_array(s string) []string {
	mut rune_list := []string{}
	mut rune_builder := []byte{}
	mut num_bytes := 0

	// https://stackoverflow.com/a/33349765 - Simple table of utf8 hex ranges
	for ch in s {
				 if ch >= 0xC0 && ch <= 0xDF { num_bytes = 2 }
		else if ch >= 0xE0 && ch <= 0xEF { num_bytes = 3 }
		else if ch >= 0xF0 && ch <= 0xF7 { num_bytes = 4 }

		if num_bytes > 0 {	// we found or are inside of a utf8 character
			rune_builder << ch
			num_bytes--
			if num_bytes == 0 {
				rune_list << rune_builder.bytestr()
				rune_builder = []
			}
		}
		else { rune_list << ch.str() }
	}

	// if rune_list.len != utf8.len(s) {
	// 	mut error_string := 'Error in string_to_array(): Generated array.len != utf8 length'
	// 			error_string += '\nOriginal string: $s'
	// 			error_string += '\nGenerated array: $rune_list'
	// 			error_string += '\nUTF8 len: ${utf8.len(s)}'
	// 			error_string += '\nArray len: $rune_list.len'
	// 	panic(error_string)
	// }
	return rune_list
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

// TODO: This vvvv
fn (t Table) calc_col_widths(tw int) []int {	// table width
	return t.get_ideal_col_widths()
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

pub fn (t Table) render(width int, height int) [][]string {
	mut rendered_table := [][]string{len: height, init: []string{len: width, init:' '} }

	// println('Table data: $t.data')
	// println('Table size: ${t.get_target_size()}')
	// println('Render size: W: $width H: $height')

	column_widths := t.calc_col_widths(width)

	// println('Col widths: $column_widths')

	mut padded_data := [][]string{ len: t.data.len, init: []string{ len: t.data[0].len, init: ''}}	// like t.data, but with spaces to fit column_widths,
	mut row_strings := []string{len: t.data.len, init: ''}

	for r, row in t.data {
		for c, col in row {
			if 			col.len <  column_widths[c] { padded_data[r][c] = (col + ' '.repeat(column_widths[c] - col.len)) }
			else if col.len == column_widths[c] { padded_data[r][c] = (col) }
			else if col.len >  column_widths[c] {
				if 			column_widths[c] > 8 {	padded_data[r][c] = (col[0..column_widths[c] - 3] + '...') }
				else if column_widths[c] > 4 {	padded_data[r][c] = (col[0..column_widths[c] - 1] + '-') }
				else 												 {	padded_data[r][c] = (col[0..column_widths[c]]) }
			}

			// merge cols into one row string and add separators
			row_strings[r] += padded_data[r][c]
			if c != row.len-1 { row_strings[r] += '│' }
		}
	}

	// Build spacer row if table has a header.
	if t.has_header == true {
		mut header_separator := ''
		for i, w in column_widths {
			header_separator += '─'.repeat(w)
			if i != column_widths.len-1 { header_separator += '┼' }
		}
		row_strings.insert(1, header_separator)
	}

	// add space to bottom if our data is too short to fit render height
	if row_strings.len <= height {
		mut bottom_space := ''
		for i, w in column_widths {
			bottom_space += ' '.repeat(w)
			if i != column_widths.len-1 { bottom_space += '│' }
		}
		for dif in row_strings.len..height { row_strings << bottom_space }
	}

	// Place results in rendered_table
	for r, _ in rendered_table {
		if r >= row_strings.len {break}
		row_array := string_to_array(row_strings[r])
		for ch, _ in rendered_table[r] {
			rendered_table[r][ch] = row_array[ch].str()
		}
	}

	return rendered_table
}
