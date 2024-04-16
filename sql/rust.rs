/// This is the main function.
fn main() {
    println!("Hello Rust!");
}

/// Increment function
pub fn inc(a: i32) -> i32 {
    a + 1
}

#[test]
fn test_inc() {
    assert_eq!(inc(1), 2);
}
