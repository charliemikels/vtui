# Notes on what I have and have not tried to fix stuff

## [Current] C Compiler crash when using Row{} and Box{} is not the first child of the parent
Stuff figured out:
- If a Box is in a Row, Row must be in another box, or the internal Box must be the first element in the Row.
- The bug is not in the renderers, removing app.run(), it's Window.draw() call, and Row.render() logic did not solve the issue.
- The bug is not past new_row(). Hard-coding row's children to [ EmptyWidget{} ] and doing nothing with new_row's Widget_List, still has the error (though the version that runs now renders only an empty widget in row (as expected)).

Stuff I've done:
- Removing window.draw() call in app.run() still crashes
- Removing app.run() call in example.v still crashes.
- Removed logic from Row.render(), still crashes
	-	Issue likely isn't with the drawing since those are all called by window from app.
- Wrapped every child in new_Row() in an array to better match the other Widgets, did not help.
- Removing table from the list of widgets does not help.
- Example.v runs fine if the only element is an empty_widget.
	- Or the only element is a box(empty_widget pair)
	- Row([box(empty), empty]) works
	- Row([empty, box(empty), empty]) FAILS
- Row alone gives a runtime divide my 0 error...
	- removed extra child wrapper in Row{} since I shouldn't need it anyways and it was making some things harder to test.
- when new_row() does not pass the widget_list to the struct, the crash case is still true, even though the child of row is hard-coded to an empty struct.
