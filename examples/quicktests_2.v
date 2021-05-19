/* Option 1 - Direct creation - ""Works"", but it assumes it's public
interface Widget {
	render() string
}

struct Window {
	root_child Widget
}

struct Table {}
fn (t Table) render() string { return 'Rendered Table Here' }

struct Box {
	child Widget
}
fn (b Box) render() string { return 'Rendered Box Here' }

struct Row {
	children []Widget
}
fn (r Row) render() string { return 'Rendered Row Here' }

new_window := Window{
	root_child: Box{
		child: Table{}
	}
}
*/

/* Option 2 - Builder function (returns self) - Table inside of box works, but row fails with an array of Widgets
interface Widget {
	render() string
}

struct Window {
	root_child Widget
}

struct Table {}
fn (t Table) render() string { return 'Rendered Table Here' }
struct TableConfig {}
fn new_table(t TableConfig) Table {return Table{} }

struct Box {
	child Widget
}
fn (b Box) render() string { return 'Rendered Box Here' }
struct BoxConfig{}
fn new_box(b BoxConfig, new_child Widget) Box {
	box := Box {
		child: new_child
	}
	return box
}

struct Row {
	children []Widget
}
fn (r Row) render() string { return 'Rendered Row Here' }
struct RowConfig{}
fn new_row(r RowConfig, new_children []Widget) Row {
	row := Row {
		children: new_children
	}
	return row
}

fn main() {
	new_window := Window {
		root_child: new_row({}, [ // This array trips stuff up (array tries to become []Table{} rather than []Widget{} )
			new_table({}),					// Widget is an interface, not a type, so the syntax to define the first item doesn't work (https://github.com/vlang/v/blob/master/doc/docs.md#arrays)
			new_box({},
				new_table({})
			)
		])
	}
}
*/

/* Option 3 - Builder function (returns Widget) - Worse, C error, bad pointers or something
interface Widget {
	render() string
}

struct Window {
	root_child Widget
}

struct Table {}
fn (t Table) render() string { return 'Rendered Table Here' }
struct TableConfig {}
fn new_table(t TableConfig) Widget {return Table{} }

struct Box {
	child Widget
}
fn (b Box) render() string { return 'Rendered Box Here' }
struct BoxConfig{}
fn new_box(b BoxConfig, new_child Widget) Widget {
	box := Box {
		child: new_child
	}
	return box
}

struct Row {
	children []Widget
}
fn (r Row) render() string { return 'Rendered Row Here' }
struct RowConfig{}
fn new_row(r RowConfig, new_children []Widget) Widget {
	row := Row {
		children: new_children
	}
	return row
}

fn main() {
	new_window := Window {
		root_child: new_box({}, new_table({}))			// C error: lvalue required as unary ‘&’ operand
		// root_child: new_row({}, [new_table({})])	// C error: lvalue required as unary ‘&’ operand
	}
}
*/

// Option 4
interface Widget {
	render() string
}

struct Window {
	root_child Widget
}

struct Table {}
fn (t Table) render() string { return 'Rendered Table Here' }
struct TableConfig {}
fn new_table(t TableConfig) Table {return Table{} }

struct AltTable {}	// Exactly the same as table, but counts as a different struct.
fn (t AltTable) render() string { return 'Rendered AltTable Here' }
struct AltTableConfig {}
fn new_alt_table(t AltTableConfig) AltTable {return AltTable{} }

struct Box {
	child Widget
}
fn (b Box) render() string { return 'Rendered Box Here' }
struct BoxConfig{}
fn new_box(b BoxConfig, new_child Widget) Box {
	box := Box {
		child: new_child
	}
	return box
}

struct Row {
	children []Widget
}
fn (r Row) render() string { return 'Rendered Row Here' }
struct RowConfig{}

fn new_row(r RowConfig, new_children []Widget) Row {
	mut children := []Widget{}
	for new_child in new_children {
		children << new_child
	}

	row := Row {
		children: children
	}

	return row
}

fn main() {
	new_window := Window {
		root_child: new_row({}, [
			new_table({}),
			new_table({}),
			new_alt_table({}),
		])
	}
	println(new_window)
}
