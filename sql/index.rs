// use std::env;
use dotenv::from_filename;
use std::{env, fs};

fn load_env() {
    let _ = from_filename("/etc/nixos/sql/.env");
}

fn main() {
    load_env();

    let db_path = env::var("DB_PATH");
    let sql_init = env::var("SQL_INIT");

    let contents = fs::read_to_string(sql_init).expect("Cant read file");
    // println!("File text:\n{contents}");

    let conn = sqlite::open("/etc/nixos/sql/_.db").unwrap();
    conn.execute(contents).unwrap();
}

#[test]
fn test_main() {
    assert_eq!(1, 1);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn env() {
        load_env()
    }
}
