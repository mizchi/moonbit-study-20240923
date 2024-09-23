pub fn foo() -> Int {
  42
  // println!("Hello, world!")
}

test "foo" {
  inspect!(foo(), content="42")
}
