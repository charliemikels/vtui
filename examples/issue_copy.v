interface Pet {
	speak() string
}

struct Dog {}
fn (d Dog) speak() string { return 'woof' }
fn (d Dog) trick() string { return '*rolls over*' }
fn new_dog() Dog { return Dog{} }
// fn new_dog_pet() Pet { return Dog{} }	// by exisiting, test_2 compiles

struct Cat {}
fn (c Cat) speak() string {	return 'meow' }
fn new_cat() Cat { return Cat{} }
// fn new_cat_pet() Pet { return Cat{} }	// by exisiting, test_2 compiles

fn main() {
	// test_1 Throws a reasonable V error (the array trys to be []Dog (First element) insted of []Pet )
	// if new_dog/new_cat returns a Pet, then it throws a different error
	// mut test_1 := [new_dog(), new_cat()]
	// mut alt_test_1 := [Dog{}, Cat{}]	// assumes Dog and Cat are public

	// test_2 throws a C error (Similar to what I was running into)
	// It compiles fine if test_3 is uncommented, or if new_dog_pet() or new_cat_pet() is uncommented
	mut test_2 := []Pet{}
	test_2 = [new_dog(), new_cat()]
	// mut alt_test_2 := []Pet{}
	// alt_test_2 = [Dog{}, Cat{}]

	// test_3 compiles fine. The existence of test_3 causes test_2 to compile
	// mut test_3 := []Pet{}
	// test_3 << new_dog()
	// test_3 << new_cat()

	// compiles fine. The existence of new_dog_pet() / new_cat_pet() causes test_2 to compile. Perhaps this is the "proper" way, but the other way should more clearly be improper.
	// mut test_4 := [new_dog_pet(), new_cat_pet()]

	println('Compiled')
}
