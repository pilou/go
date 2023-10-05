package main

import (
	"fmt"
	"os"
)

func main() {
	SayHello()
}

func SayHello() {
	s := "Hello from Go with notso secret env " + os.Getenv("A_SECRET")
	fmt.Println(s)
}
