package main

import "testing"

func TestSayHello(t *testing.T) {
	SayHello()

	t.Error("nooo")
}
