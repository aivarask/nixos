// use std::env;
use std::fs;

fn main() {
    let contents = fs::read_to_string("/etc/nixos/sql/index.sql").expect("Cant read file");
    // println!("File text:\n{contents}");

    let conn = sqlite::open("/etc/nixos/sql/_.db").unwrap();
    conn.execute(contents).unwrap();
}
