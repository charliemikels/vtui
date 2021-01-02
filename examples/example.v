// Now when I say "example," I actualy mean the code I am using to test vtui.
// This is not a good example yet.

import charliemikels.vtui as ui
// import term


fn main() {

	// window := ui.new_window({},
	// 	ui.new_box({title: 'Outer Row Test'},
	// 		ui.new_table({
	// 			data: [
	// 				['Name', 'Friends'],
	// 				['Kevin', 'Derek'],
	// 				['Derek', 'Kevin, Daniel'],
	// 				['Daniel', 'Derek, Kevin\'s Brother'],
	// 				['Kevin\'s brother', 'Yes']
	// 			]
	// 		})
	// 	)		// outer box ends here.
	// )
	// app := ui.new_app({}, window)
	// app.run()

	println('Compiles')

	// DEBUG vvvv

	// only_ew						:= ui.new_row({}, [ui.new_empty_widget()]) // works fine
	// box_after_ew			:= ui.new_row({}, [ui.new_empty_widget(), ui.new_box({}, ui.new_empty_widget() )])		// Only works if box_before_ew is uncommented.
	// box_before_ew			:= ui.new_row({}, [ui.new_box({}, ui.new_empty_widget() ), ui.new_empty_widget()])		// works fine
	// bow_wrapping_row	:= ui.new_box({}, ui.new_row({}, [ui.new_empty_widget()]) )														// works fine


	// Set 2
	mut box_after_ew_array := []ui.Widget{}
	box_after_ew_array = [ui.new_empty_widget(), ui.new_box({}, ui.new_empty_widget() )]
	// box_after_ew_array << ui.new_empty_widget()
	// box_after_ew_array << ui.new_box({}, ui.new_empty_widget() )

	// mut box_after_ew_array_2 := []ui.Widget{}
	// box_after_ew_array_2 = [ui.Box{}, ui.EmptyWidget{}]

	// box_after_ew_array_3 := [ui.Box{}, ui.EmptyWidget{}]

	// box_before_ew_array := [ui.new_box({}, ui.new_empty_widget() ), ui.new_empty_widget()]

	// DEBUG ^^^^

}
