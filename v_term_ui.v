module v_term_ui

import term

// see also https://en.wikipedia.org/wiki/Box-drawing_character#Unicode
// see also https://github.com/tianyazc/vttable OR https://github.com/chulinx/vttable

// struct window // window does the rendering and placement of a list of children

pub interface Widget {
	draw()
	unfocus()
	focus()
	is_focused() 	 bool
	pos() 				(int, int)
	// min_size() 	 	(int, int)
	// target_size()	(int, int)
	size()				(int, int)
	// get_parrent()	&Widget
}

struct Window {
	mut:
		w int
		h int
		children []Widget
}

pub struct WindowConfig {
}

struct Box {
	x int
	y int
	w int
	h int
	title string
	// actions []string	// lists hot-key actions the user can do.
	children []Widget
}

fn (b Box) draw() {
	// linestyle
	mut style := map[string]string
	style['h'] = '─'
	style['v'] = '│'		//  ┌─┤Title├─────┐
	style['nw'] = '┌'		//	│             │
	style['ne'] = '┐'		//  └─────────────┘
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

	// max_x, max_y := term.get_terminal_size()

	// edges
	draw_line(b.x, b.y, b.w, `h`, style['h'])					// left
	draw_line(b.x, b.y + b.h -1, b.w, `h`, style['h'])	// right
	draw_line(b.x, b.y , b.h, `v`, style['v'])					// top
	draw_line(b.x + b.w -1, b.y, b.h, `v`, style['v']) // bot

	// corners
	term.set_cursor_position(b.x ,b.y)
	print(style['nw'])
	term.set_cursor_position(b.x ,b.y + b.h -1)
	print(style['sw'])
	term.set_cursor_position(b.x + b.w -1, b.y)
	print(style['ne'])
	term.set_cursor_position(b.x + b.w -1, b.y + b.h -1)
	print(style['se'])

	// title
	if b.title != '' {
		term.set_cursor_position(b.x + 2, b.y)
		print(style['title_l']+b.title+style['title_r'])
	}

}


fn draw_line(x, y, len int, dir byte, ch string) {
	// dir: h, v
	if true {
		mut i := 0
		if dir == `v` {
			for i < len {
				term.set_cursor_position(x,y+i)
				print(ch)
				i++
			}
		}
		else if dir == `h` {
			for i < len {
				term.set_cursor_position(x+i,y)
				print(ch)
				i++
			}
		}
	}
}

pub fn draw_box(x, y, w, h int, title string) {
	// tmp fn to test innitial layout
	new_box := Box{
		x: x
		y: y
		w: w
		h: h
		title: title
	}
	new_box.draw()
}

pub fn start() {
	term.clear()
}
