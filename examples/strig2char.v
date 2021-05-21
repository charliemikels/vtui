// import charliemikels.vtui as ui
// import term

fn main() {
	s := "this is a string"
	mut a := []string{}

	for char in s {
		a << rune(char).str()
	}

	println(a)
}
