package testdir

import (
	"os"
	"path/filepath"
	"testing"
)

func GoModRoot(t *testing.T) string {
	dir, err := os.Getwd()
	if err != nil {
		t.Fatalf("Failed to get current directory: %v", err)
	}

	for {
		if _, err := os.Stat(filepath.Join(dir, "go.mod")); err == nil {
			return dir
		}

		parent := filepath.Dir(dir)
		if parent == dir {
			t.Fatalf("go.mod file not found")
		}
		dir = parent
	}
}

func FromGoModRoot(t *testing.T, relpath string) string {
	return filepath.Join(GoModRoot(t), relpath)
}
