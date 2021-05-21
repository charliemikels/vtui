module vtui

// import term

struct Box {
	title string
	child Widget = new_empty_widget()
}

pub struct BoxConfig {
	title string = 'New Box'
}

pub fn new_box(c BoxConfig, child Widget) Box { // (c BoxConfig/*, child Widget*/)
	return Box{
		title: c.title
		child: child
	}
}

fn (b Box) render(w int, h int) [][]string {
	// linestyle
	mut style := map[string]string{}
	style['h'] = '─'
	style['v'] = '│' // ┌─┤Title├─────┐
	style['nw'] = '┌' // │             │
	style['ne'] = '┐' // └─────────────┘
	style['sw'] = '└'
	style['se'] = '┘'
	style['title_l'] = '┤'
	style['title_r'] = '├'
	// backup style:
	// style['h'] = '-'
	// style['v'] = '|'
	// style['nw'] = '+'
	// style['ne'] = '+'
	// style['sw'] = '+'
	// style['se'] = '+'
	// style['title_l'] = '['
	// style['title_r'] = ']'
	// render
	mut rendered_box := [][]string{len: h, init: []string{len: w, init: ' '}}
	// fill left/right col with vertical lines
	// println("H: $h, W: $w")
	for r in 0 .. h {
		// println("R: $r")
		rendered_box[r][0] = style['v']
		rendered_box[r][w - 1] = style['v']
	}
	// fill top + bottom row with horizontal lines
	for c in 0 .. w {
		// println("C: $c")
		rendered_box[0][c] = style['h']
		rendered_box[h - 1][c] = style['h']
	}
	// add corners
	rendered_box[0][0] = style['nw']
	rendered_box[0][w - 1] = style['ne']
	rendered_box[h - 1][w - 1] = style['se']
	rendered_box[h - 1][0] = style['sw']
	// add title
	if b.title != '' {
		// mut i_end 	:= w - 2 //(preserve corners)
		mut i_start := 1
		do_title_holder := true // ( i_end - i_start > 4 )	// minimum title len
		if do_title_holder {
			rendered_box[0][i_start] = style['title_l']
			i_start++
		}
		// apply title to render
		for i, chr in b.title {
			// println('$i, $chr, $w')
			if i + i_start < w - 1 {
				rendered_box[0][i + i_start] = rune(chr).str()
			} else {
				break
			}
		}
		if do_title_holder {
			if b.title.len + i_start > w - 2 {
				rendered_box[0][w - 2] = style['title_r']
			} else {
				rendered_box[0][b.title.len + i_start] = style['title_r']
			}
		}
	}
	// Render Children
	rendered_child := b.child.render(w - 2, h - 2)
	// println( rendered_child )
	// println( rendered_box )
	for r in 0 .. h - 2 {
		for c in 0 .. w - 2 {
			// print( rendered_child )
			rendered_box[r + 1][c + 1] = rendered_child[r][c]
		}
		// print('\n')
	}
	return rendered_box
}

fn (b Box) get_target_size() (int, int) {
	w, h := b.child.get_target_size()
	return w + 2, h + 2
}

fn (b Box) to_string() string {
	return 'Box($b.title)'
}
