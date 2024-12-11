package testfile

import (
	"io"
	"os"
	"testing"
)

func Copy(t testing.TB, src, dest string) {
	t.Helper()
	reader, err := os.Open(src)
	if err != nil {
		t.Fatalf("Failed to open source file: %v", err)
	}
	defer reader.Close()

	writer, err := os.Create(dest)
	if err != nil {
		t.Fatalf("Failed to create destination file: %v", err)
	}
	defer writer.Close()

	if _, err := io.Copy(writer, reader); err != nil {
		t.Fatalf("Failed to copy file: %v", err)
	}
}
