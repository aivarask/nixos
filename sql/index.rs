// use std::env;
use std::fs;

fn main() {
    let contents = fs::read_to_string("/etc/nixos/sql/index.sql").expect("Cant read file");
    // println!("File text:\n{contents}");

    let conn = sqlite::open("/etc/nixos/sql/_.db").unwrap();
    conn.execute(contents).unwrap();
}

#[test]
fn test_main() {
    assert_eq!(1, 1);
}

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// This is a really bad adding function, its purpose is to fail in this
// example.
#[allow(dead_code)]
fn bad_add(a: i32, b: i32) -> i32 {
    a - b
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1, 2), 3);
    }

    #[test]
    fn test_bad_add() {
        // This assert would fire and test will fail.
        // Please note, that private functions can be tested too!
        assert_eq!(bad_add(1, 2), 3);
    }
}
