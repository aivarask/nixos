package main

import (
	"database/sql"

	// "fmt"
	"log"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

func main() {

	content, err := os.ReadFile("/etc/nixos/sql/index.sql")
	if err != nil {
		log.Fatal(err)
	}
	// fmt.Println(string(content))

	db, err := sql.Open("sqlite3", "/etc/nixos/sql/_.db")
	if err != nil {
		log.Fatal(err)
	}

	_, err = db.Exec(string(content))
	if err != nil {
		log.Printf("%q: %s\n", err, string(content))
		return
	}

	defer db.Close()
}
