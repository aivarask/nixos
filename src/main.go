package main

import "fmt"
import "time"

func main() {
	lang := "go"
	fmt.Println("Hello go", lang)
	start := time.Now()
	fmt.Println(start)
}

func hello() {
	fmt.Println("Hello go")

}
