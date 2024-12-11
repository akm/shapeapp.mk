package testdir

import (
	"os"
	"testing"
)

func Cd(t testing.TB, path string) func() {
	origWd, err := os.Getwd()
	if err != nil {
		t.Fatalf("Failed to get current directory: %v", err)
	}
	if err := os.Chdir(path); err != nil {
		t.Fatalf("Failed to change directory to %s: %v", path, err)
	}
	return func() {
		if err := os.Chdir(origWd); err != nil {
			t.Fatalf("Failed to change directory to %s: %v", origWd, err)
		}
	}
}

func MkdirAll(t testing.TB, path string) string {
	if err := os.MkdirAll(path, 0755); err != nil {
		t.Fatalf("Failed to create directory: %v", err)
	}
	return path
}
