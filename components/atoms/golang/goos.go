package main

import (
	"fmt"
	"os"
	"runtime"
)

func main() {
	fmt.Fprint(os.Stdout, runtime.GOOS)
}
