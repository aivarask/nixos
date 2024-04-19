package sql

import (
	"database/sql"

	// "fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/mattn/go-sqlite3"
)

const DB = "DB_PATH"
const SQL = "SQL_INIT"

func main() {

	loadEnv()

	content, err := os.ReadFile(getSqlInitPath())
	if err != nil {
		log.Fatal(err)
	}
	// fmt.Println(string(content))

	db, err := sql.Open("sqlite3", getDBPath())
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

func loadEnv() error {
	return godotenv.Load("/etc/nixos/sql/.env")
}

func getDBPath() string {
	return os.Getenv("DB_PATH")
}

func getSqlInitPath() string {
	return os.Getenv("SQL_INIT")
}
