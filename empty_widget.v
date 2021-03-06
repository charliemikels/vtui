module vtui

struct EmptyWidget {
}

pub fn new_empty_widget() Widget {
	return EmptyWidget{}
}

fn (ew EmptyWidget) render(w int, h int) [][]string {
	return [][]string{len: h, init: []string{len: w, init: ' '}}
}

fn (ew EmptyWidget) get_target_size() (int, int) {
	return 0, 0
}

fn (ew EmptyWidget) to_string() string {
	return 'EmptyWidget'
}
