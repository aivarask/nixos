package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestMain(t *testing.T) {
	assert.Equal(t, 123, 123, "they should be equal")
	msg := 2
	if msg != 2 {
		t.Fatalf(`Not match`)
	}
}
