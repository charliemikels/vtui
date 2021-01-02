module vtui

// import term
interface Widget {
	render(int, int) [][]string // width, height ([row][col])
	get_target_size() (int, int) // width, height
	to_string() string // for debug println
	// str() string // for debug println

}

fn sum(a []int) int {
	mut sum := 0
	for num in a {
		sum += num
	}
	return sum
}
