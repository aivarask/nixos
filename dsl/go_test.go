package main

import (
	"testing"
)

// This is increment function
func Inc(n int) int {
	return n + 1
}

func TestInc(t *testing.T) {
	msg := Inc(1)
	if msg != 2 {
		t.Fatalf(`Wrong increment`)
	}
}
