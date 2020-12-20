module vtui

// import term
interface Widget {
	render(int, int) [][]string // width, height ([row][col])
	get_target_size() (int, int) // width, height
}
