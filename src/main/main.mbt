fn main {
  println("Hello, World!")
  // template string
  let world = "World"
  println("Hello, \{world}")

  // variables and built-in types
  let _x = "hello"
  let mut y : Int = 2
  y = 3
  let _multiline_text =
    #| hello
    #| world
    #| multiline
  let map : Map[String, Int] = { "x": 1, "y": 2 }
  let _ = map.contains("x")
  let items = [1, 2, 3]
  items.push(4)

  // if
  if y == 2 {
    println("y is 1")
  }
  // loop
  for x in [1, 2, 3] {
    println(x)
  }
  for k, v in { "x": 1, "y": 2 } {
    println("\{k} => \{v}")
  }
  for i = 1; i < 5; i = i + 1 {
    println(i)
  }

  // match
  let z = 3
  let _ = match z % 2 {
    0 => 0
    1 => 1
  }

}

// inline test
test {
  assert_eq!(1, 1)
}
