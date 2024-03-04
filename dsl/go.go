package main

import "fmt"
import "time"

// This is main function
func main() {
	lang := "go"
	fmt.Println("Hello go", lang)
	start := time.Now()
	fmt.Println(start)
}

// This is hello function
func Hello(name string) string {
	return ""
}
