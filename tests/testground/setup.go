package testground

import (
	"os"
	"testing"

	"github.com/akm/shapeapp.mk/tests/testdir"
	"github.com/akm/shapeapp.mk/tests/testexec"
)

func Setup(t *testing.T) func() {
	t.Helper()

	// Suppress make's output
	os.Setenv("MAKEFLAGS", "--no-print-directory")

	r := testdir.Setup(t, ".", testdir.FromGoModRoot(t, "grounds"))
	testexec.Run(t, "git", "init")
	testexec.Run(t, "git", "add", ".")
	testexec.Run(t, "git", "commit", "-m", "Initial commit")

	return r
}
