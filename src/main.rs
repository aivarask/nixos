use time::OffsetDateTime;

fn main() {
    let now = OffsetDateTime::now_utc();
    println!("{now}");
    println!("Hello rust");
}

/// Adds two numbers
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[test]
fn test_add() {
    assert_eq!(add(1, 2), 3);
}
