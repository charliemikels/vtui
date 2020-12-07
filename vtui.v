module vtui

import term

pub interface Widget {
	render(int, int) [][]string // width, height
	get_target_size() (int, int) // width, height
}

pub fn start() {
	term.clear()
	// enter vim-like "alternitive mode"?? see https://stackoverflow.com/questions/11023929/using-the-alternate-screen-in-a-bash-script
	// render window
	// wait for user input / event
	// re-render window (loop until exit)
	// exit vim like "alternitive mode"
}
