package main

import (
	"os"

	echo "github.com/pilou/gomodule"
)

func main() {
	SayHello()
}

func SayHello() {
	s := "Hello from Go with notso secret env " + os.Getenv("A_SECRET")
	echo.Echo(s)
}
