// Now when I say "example," I actualy mean the code I am using to test vtui.
// This is not a good example yet.

import charliemikels.vtui as ui
// import term


fn main() {
	// ui.start()

	window := ui.new_window({},
		ui.new_box({title: 'Win Test'},
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
	)

	window.draw(40, 30, 0, 0)

	// term.set_cursor_position(1,40)

}
