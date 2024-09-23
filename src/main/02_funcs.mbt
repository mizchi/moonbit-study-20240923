// function
fn add(a : Int, b : Int) -> Int {
  return a + b
}

test "add" {
  let a = 1
  let b = 2
  let c = add(a, b)
  assert_eq!(c, 3)
}

// generics
fn self[T](v : T) -> T {
  return v
}

test "self" {
  let a = 1
  let b : Int = self(a)
  assert_eq!(a, b)
}

// generics trait
fn lge[X : Compare](a : X, b : X) -> Bool {
  return a >= b
}

test "lge" {
  let a = 1
  let b = 2
  let c = lge(a, b)
  assert_eq!(c, false)
  let a = 1.1
  let b = 2.2
  let c = lge(a, b)
  assert_eq!(c, false)
}

// trait
trait Animal {
  speak(Self) -> String
}

struct Duck {
  name : String
}

fn speak(self : Duck) -> String {
  "\{self.name} Quack!"
}

test "Duck" {
  let duck = Duck::{ name: "Donald" } as Animal
  inspect!(duck.speak(), content="Donald Quack!")
}
