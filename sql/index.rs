// use std::env;
use dotenv::from_filename;
use std::{env, fs};

fn load_env() {
    let _ = from_filename("/etc/nixos/sql/.env");
}

fn main() {
    load_env();
    println!("Hell");

    // let sql_init = env::var("SQL_INIT");
    let key = "DB_PATH";
    match env::var(key) {
        Ok(val) => println!("{key}: {val:?}"),
        Err(e) => println!("couldn't interpret {key}: {e}"),
    }

    let contents = fs::read_to_string("/etc/nixos/sql/index.sql").expect("Cant read file");
    // println!("File text:\n{contents}");
    let conn = sqlite::open("/etc/nixos/sql/_.db").unwrap();
    conn.execute(contents).unwrap();
}

#[cfg(test)]
mod tests {
    use std::env;

    use crate::load_env;

    #[test]
    fn test_main() {
        let n = 1;
        println!("test_main");
        assert_eq!(1, n);
    }
    #[test]
    fn env() {
        load_env();
        println!("Woo");
        let key = "DB_PATH";
        match env::var(key) {
            Ok(val) => println!("{key}: {val:?}"),
            Err(e) => println!("couldn't interpret {key}: {e}"),
        }
        assert_eq!(1, 1);
    }
}
