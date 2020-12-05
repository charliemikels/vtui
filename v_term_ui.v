module v_term_ui

import term

// see also https://en.wikipedia.org/wiki/Box-drawing_character#Unicode
// see also https://github.com/tianyazc/vttable OR https://github.com/chulinx/vttable
// struct window // window does the rendering and placement of a list of children
pub fn draw(text []string, x int, y int) {
	for i, r in text {
		term.set_cursor_position(x: x, y: y + i)
		print(r)
		// for ch in r {
		// print(y+i)
		// }
	}
}

pub interface Widget {
	render(int, int) [][]string		// width, height
	get_target_size() (int, int)	// width, height
}

// unfocus()
// focus()
// is_focused() 	 bool
// pos() 				(int, int)
// size()				(int, int)
// min_size() 	 	(int, int)
// get_parrent()	&Widget
// get_children		[]&Widget
struct Window {
mut:
	w        int
	h        int
	children []&Widget
}

pub struct WindowConfig {
}

pub fn start() {
	term.clear()
	// enter vim like "alternitive mode"
	// see https://stackoverflow.com/questions/11023929/using-the-alternate-screen-in-a-bash-script
	/*
	os.exec('tput smcup') or {
		return error("Terminal didn't like 'tput smcup'")
	}



	// exit vim like "alternitive mode"
	os.exec('tput rmcup')
	*/
}
