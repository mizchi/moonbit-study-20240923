pub fn hello() -> Unit {
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
  let t : Int? = Some(5) // equal to Option[Int]
  let _mapped = t.map_or(3, fn(x) { x * 2 })
  let _bool : Bool = match t {
    Some(x) => x % 2 == 0
    None => false
  }

}

// inline test
test {
  let a = 1
  let b = 2
  let c = add(a, b)
  assert_eq!(c, 3)
}
