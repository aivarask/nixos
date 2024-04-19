package sql

import (
	"testing"

	"github.com/stretchr/testify/assert"
	// "github.com/joho/godotenv"
)

func TestLoadEnvNoErrors(t *testing.T) {
	err := loadEnv()
	if err != nil {
		t.Fatal("Error loading .env file")
	}
}

func TestDBPathNotEmpty(t *testing.T) {
	p := getDBPath()
	if p == "" {
		t.Fatal("DB path not loaded")
	}
}

func TestSqlInitNotEmpty(t *testing.T) {
	if getSqlInitPath() == "" {
		t.Fatal("Sql initial script path empty")
	}
}

func TestMain(t *testing.T) {
	assert.Equal(t, 1, 1, "they should be equal")
}

