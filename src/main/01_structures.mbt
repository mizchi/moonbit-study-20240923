// data structure
enum MyEnum {
  A
  B
}

struct Point {
  x : Int
  y : Int
} derive(Show)

fn distance(self : Point, other : Point) -> Double {
  (self.x * other.x + self.y * other.y).to_double().sqrt()
}

// Generics and derived trait
struct Point3d[T] {
  x : T
  y : T
  z : T
} derive(Show)

fn _structure_example() -> Unit {
  // structure
  let p = Point::{ x: 1, y: 2 }
  println(p.distance(Point::{ x: 3, y: 4 }))
  let list = [1, p.x, p.y]
  let mapped = list.map(fn(x) -> Int { return x + 1 })
  println(mapped)
}
