module vtui

pub struct EmptyWidget {}

pub fn new_empty_widget() &EmptyWidget {
	return &EmptyWidget{}
}

// PUBLIC FOR TESTING
pub fn (ew EmptyWidget) render(w int, h int) [][]string {
	return [][]string{len: h, init: []string{len: w, init: '0'}}
}

pub fn (ew EmptyWidget) get_target_size() (int, int) {
	return 0, 0
}
