module vtui

import term

// import time
// Window is in charge of drawing the UI (and managing the layout).
struct Window {
	box_characters map[string]string
mut:
	child          []&Widget // An array due to a bug. When interfaces are smarter, just use &Widget
}

pub struct WindowConfig {
}

pub fn new_window(w WindowConfig, child &Widget) &Window {
	mut widget_list := []&Widget{}
	widget_list << child
	mut box_style := map[string]string{}
	// '─' is 'ew' bc the ends of the line connect to the east and west sides
	// The naming order is always n, s, e, then w
	if true { // TODO: ask if terminal can handle these characters (or launch param)
		box_style['ns'] = '│'
		box_style['ew'] = '─'
		box_style['ne'] = '└'
		box_style['nw'] = '┘'
		box_style['se'] = '┌'
		box_style['sw'] = '┐'
		box_style['nse'] = '├'
		box_style['nsw'] = '┤'
	} else {
		box_style['ns'] = '|'
		box_style['ew'] = '-'
		box_style['ne'] = '+'
		box_style['nw'] = '+'
		box_style['se'] = '+'
		box_style['sw'] = '+'
		box_style['nse'] = '|'
		box_style['nsw'] = '|'
	}
	return &Window{
		// title: w.title
		child: widget_list
		box_characters: box_style
	}
}

pub fn (win Window) draw(width int, height int, x_off int, y_off int) {
	rendered_child := win.child[0].render(width, height)
	term.clear()
	for w in 0 .. width {
		for h in 0 .. height {
			term.set_cursor_position(x: w + 1 + x_off, y: h + 1 + y_off)
			print(rendered_child[h][w])
		}
	}
}
