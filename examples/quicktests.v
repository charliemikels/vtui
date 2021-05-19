interface Pet {
	speak() string
	// str() string
}

struct Dog {
	name string = 'no_name'
	friend Pet
}
fn (d Dog) speak() string { return 'woof, my friend' }
fn (d Dog) trick() string { return '*rolls over*' }
fn (d Dog) str() string { return 'Dog!'}
fn new_dog(friend Pet) Dog {
	return Dog{
		friend: friend
	}
}
// fn new_dog_pet() Pet { return Dog{} }

struct Cat {}
fn (c Cat) speak() string {	return 'meow' }
fn (c Cat) str() string { return 'Cat!'}

fn new_cat() Cat { return Cat{} }
fn new_cat_pet() Pet { return Cat{} }

fn main() {
	// test_1 Throws a reasonable V error (the array trys to be []Dog (First element) insted of []Pet )
	// if new_dog/new_cat returns a Pet, then it throws a different error
	// mut test_1 := [new_dog(new_cat()), new_cat()]
	// mut alt_test_1 := [Dog{}, Cat{}]	// assums Dog and Cat are public

	// test_2 throws a C error (What I was running into)
	mut test_2 := []Pet{}
	test_2 = [new_dog(new_cat()), new_cat()]
	// mut alt_test_2 := []Pet{}
	// alt_test_2 = [Dog{}, Cat{}]

	// test_3 compiles fine, and causes test_2 to compile
	// mut test_3 := []Pet{}
	// test_3 << new_dog(new_cat())
	// test_3 << new_cat()

	// compiles fine, and after running once, test 2 always compiled afterwords???
	// // mut test_4 := [new_dog_pet(), new_cat_pet()]

	println('Compiles')
}
