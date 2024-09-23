// data structure
enum _T {
  A
  B
}

enum Tree {
  Node(Int, Tree, Tree)
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

test {
  // structure
  let p = Point::{ x: 1, y: 2 }
  inspect!(p, content="{x: 1, y: 2}")
  inspect!(p.distance(Point::{ x: 4, y: 6 }), content="4")
}

// JSON serialization
struct MyRecord {
  field1 : Int
  field2 : MyEnum
} derive(Show, ToJson, FromJson)

enum MyEnum {
  Constr1(Int, Bool?)
  Constr2
} derive(Show, ToJson, FromJson)

test "json" {
  let record = { field1: 20, field2: Constr1(5, Some(true)) }
  println(record.to_json().stringify())
  let json = record.to_json()
  inspect!(record, content="{field1: 20, field2: Constr1(5, Some(true))}")
  let record : MyRecord = @json.from_json!(json)
  inspect!(record, content="{field1: 20, field2: Constr1(5, Some(true))}")
}

// error handling
type! MyErr String derive(Show)

fn f() -> Unit! {
  raise MyErr("err")
}

// struct 
test "json" {
  try {
    f!()
  } catch {
    MyErr(e) => inspect!(e, content="err")
    other => raise other
  }
}

test "Option" {
  let t : Int? = Some(5)
  // equal to Option[Int]
  inspect!(t, content="Some(5)")
  let a = Some(5)
  assert_eq!(a.map_or(3, fn(x) { x * 2 }), 10)
}
