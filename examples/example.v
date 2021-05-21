import charliemikels.vtui as ui
// import term

fn main() {
	window := ui.new_window({}, ui.new_row({}, [
		ui.new_box({ title: 'Box' }, ui.new_box({ title: 'box 2' }, ui.new_empty_widget())),
		ui.new_box({ title: 'Table' }, ui.new_table(
			data: [
				['Name', 'Friends'],
				['Kevin', 'Derek'],
				['Derek', 'Kevin, Daniel'],
				['Daniel', "Derek, Kevin's Brother"],
				["Kevin's brother", 'Yes'],
			]
		)),
	]))

	// window := ui.new_window({},
	// 	ui.new_box({ title: 'Box' },
	// 		ui.new_box({ title: 'box 2' },
	// 			ui.new_empty_widget()
	// 		)
	// 	)
	// )

	app := ui.new_app({}, window)
	app.run()
}
