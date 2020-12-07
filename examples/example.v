// Now when I say "example," I actualy mean the code I am using to test vtui.
// This is not a good example yet.

import charliemikels.vtui as ui
// import term


fn main() {
	ui.start()

	// fn_box := ui.new_box({title: 'Big box'}, ui.new_box({title: 'Small box'}, ui.new_empty_widget() ) )
	fn_box := ui.new_box({title: 'Table'},
		ui.new_table({
			data: [
				['Name', 'Age', 'Cat or Dog'],
				['Kevin', '19', 'Cat'],
				['Derek', '15', 'Dog'],
				['Daniel', '22', 'Cat'],
				['Kevin\'s brother', '8', 'FISH']
			]
		})
	)

	rendered_box := fn_box.render(35,8)
	// rendered_box := fn_table.render(30,30)

	for row in rendered_box {
		println("")
		for char in row {
			print(char)
		}
	}
	println("")

	// term.set_cursor_position(1,40)

}
