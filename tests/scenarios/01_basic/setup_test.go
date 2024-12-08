package basic

import (
	"testing"

	"github.com/akm/shapeapp.mk/tests/testdir"
	"github.com/akm/shapeapp.mk/tests/testfile"
	"github.com/akm/shapeapp.mk/tests/testground"
)

func TestSetup(t *testing.T) {
	teardown := testground.Setup(t)

	testdir.Cd(t, testdir.MkdirAll(t, "my-app1"))
	run(t, "git", "init")
	run(t, "/bin/bash", "-c",
		`$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/main/scripts/install.sh)`)
	run(t, "make", "setup")

	// Setup dbmigrations
	run(t, "make", "-C", "backends/dbmigrations", "setup")
	testfile.Copy(t, "20240715145233_create_tasks.sql", "my-app1/backends/dbmigrations/migrations")
	run(t, "make", "-C", "backends/dbmigrations") // Run build, lint, test

	teardown()
}
