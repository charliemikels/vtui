module vtui

import term

// App is in charge of running the UI. The event loop will live here
struct App {
	is_interactive bool
	// use_fixed_size bool
	// fixed_size_w 	 int
	// fixed_size_h 	 int
mut:
	w              &Window
}

pub struct AppConfig {
	is_interactive bool
}

pub fn new_app(c AppConfig, win &Window) &App {
	app := App{
		w: win
		is_interactive: c.is_interactive
	}
	return &app
}

pub fn (mut a App) change_window(win &Window) {
	a.w = win
}

pub fn (app App) run() {
	term.clear()
	// enter vim-like "alternitive mode"?? see https://stackoverflow.com/questions/11023929/using-the-alternate-screen-in-a-bash-script
	// begin input/event loop
	// render window
	mut tw, th := term.get_terminal_size()
	app.w.draw(tw, th, 0, 0)
	// wait for user input / event
	// exit on a quit event
}
