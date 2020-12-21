// Now when I say "example," I actualy mean the code I am using to test vtui.
// This is not a good example yet.

import charliemikels.vtui as ui
// import term


fn main() {

	// thing := [	ui.new_empty_widget(), ui.new_empty_widget(), ui.new_empty_widget() ]
	// println('thing.len: ${thing.len}')


	// window := ui.new_window({},
	// 	ui.new_row({}, [
	// 	// 	ui.new_box({title: 'Win Test'},
	// 	// 		ui.new_table({
	// 	// 			data: [
	// 	// 				['Name', 'Age', 'Cat or Dog'],
	// 	// 				['Kevin', '19', 'Cat'],
	// 	// 				['Derek', '15', 'Dog'],
	// 	// 				['Daniel', '22', 'Cat'],
	// 	// 				['Kevin\'s brother', '8', 'FISH']
	// 	// 			]
	// 	// 		})
	// 	// 	),
	// 	//
	// 	// 	ui.new_box({title: 'Row Test'},
	// 	// 		ui.new_table({
	// 	// 			data: [
	// 	// 				['Name', 'Age', 'Cat or Dog'],
	// 	// 				['Kevin', '19', 'Cat'],
	// 	// 				['Derek', '15', 'Dog'],
	// 	// 				['Daniel', '22', 'Cat'],
	// 	// 				['Kevin\'s brother', '8', 'FISH']
	// 	// 			]
	// 	// 		})
	// 	// 	)
	// 	// ])
	// 	ui.new_empty_widget(), ui.new_empty_widget(), ui.new_empty_widget() ])
	// )

	// println(*window)

	// app := ui.new_app({}, window)
	app := ui.new_app({},
		ui.new_window({},
			ui.new_box({title: 'Outer Row Test'},		// Removing this gets a C error if new row starts with anything other than a box
				ui.new_row({}, [
					ui.new_empty_widget(),
					ui.new_box({title: 'Row Test'},
						ui.new_table({
							data: [
								['Fruit', 'Goodness'],
								['Apples', 'Very good'],
								['Banana', 'Less good'],
								['Sandwich', 'Not a fruit but still good'],
							]
						})
					),

					ui.new_empty_widget(),
					ui.new_table({
						data: [
							['Name', 'Friends'],
							['Kevin', 'Derek'],
							['Derek', 'Kevin, Daniel'],
							['Daniel', 'Derek, Kevin\'s Brother'],
							['Kevin\'s brother', 'Yes']
						]
					})
				])
			)		// outer box ends here.
		)
	)


	app.run()

	// println('------')
	// println(17/3)
	// println(17%3)

}
