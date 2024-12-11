package testfile

import (
	"os"
	"strings"
	"testing"
)

func Replace(t testing.TB, path string, search, replace string) {
	t.Helper()

	b, err := os.ReadFile(path)
	if err != nil {
		t.Fatalf("Failed to read file: %v", err)
	}

	content := string(b)
	content = strings.ReplaceAll(content, search, replace)

	if err := os.WriteFile(path, []byte(content), 0644); err != nil {
		t.Fatalf("Failed to write file: %v", err)
	}
}
