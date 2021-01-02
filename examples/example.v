// Now when I say "example," I actualy mean the code I am using to test vtui.
// This is not a good example yet.

import charliemikels.vtui as ui
// import term


fn main() {

	// window := ui.new_window({},
	// 	ui.new_empty_widget()
	// 	// ui.new_box({title: 'Outer Row Test'},
	// 	// 	ui.new_table({
	// 	// 		data: [
	// 	// 			['Name', 'Friends'],
	// 	// 			['Kevin', 'Derek'],
	// 	// 			['Derek', 'Kevin, Daniel'],
	// 	// 			['Daniel', 'Derek, Kevin\'s Brother'],
	// 	// 			['Kevin\'s brother', 'Yes']
	// 	// 		]
	// 	// 	})
	// 	// )		// outer box ends here.
	// )
	// app := ui.new_app({}, window)
	// app.run()

	println('Compiles')

	// DEBUG vvvv

	// mut test_1 := []ui.Widget{}
	// test_1 = [
	// 	ui.new_empty_widget(),
	// 	// ui.new_table({
	// 	// 	data: [
	// 	// 		['Name', 'Friends'],
	// 	// 		['Kevin', 'Derek'],
	// 	// 		['Derek', 'Kevin, Daniel'],
	// 	// 		['Daniel', 'Derek, Kevin\'s Brother'],
	// 	// 		['Kevin\'s brother', 'Yes']
	// 	// 	]
	// 	// }),
	// ]

	// test_2 := ui.new_box({}, ui.new_empty_widget())

	// test_3 := ui.new_empty_widget()

	test_4 := ui.new_row({}, ui.new_empty_widget(), ui.new_empty_widget())
	// println(test_4.to_string())



	// test_5 := ui.new_box({}, ui.EmptyWidget{})
	// test_5 := ui.new_box({}, ui.new_empty_widget())


	// DEBUG ^^^^

}
