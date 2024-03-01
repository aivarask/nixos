package main

import (
    "testing"
)

func Hello(name string) (string) {
    return ""
}

func TestHelloEmpty(t *testing.T) {
    msg := Hello("")
    if msg != "" {
        t.Fatalf(`Hello("") = %q, %v, want "", error`, msg, nil)
    }
}

