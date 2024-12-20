package basic

import (
	"os"
	"testing"

	"github.com/akm/shapeapp.mk/tests/testdir"
	"github.com/akm/shapeapp.mk/tests/testfile"
	"github.com/akm/shapeapp.mk/tests/testground"
)

func TestSetup(t *testing.T) {
	teardown := testground.Setup(t)

	testdir.Cd(t, testdir.MkdirAll(t, "my-app1"))
	run(t, "git", "init")
	// run(t, "/bin/bash", "-c",
	// 	`$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/main/scripts/install.sh)`)
	run(t, "curl", "-fsSL", "https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/main/scripts/install.sh", "-o", "install.sh")

	// replace git@github.com:akm/shapeapp.mk.git to https://github.com/akm/shapeapp.mk.git
	testfile.Replace(t, "install.sh", "git@github.com:akm", "https://github.com/akm")
	run(t, "/bin/bash", "install.sh")
	run(t, "make", "setup")

	// Setup dbmigrations
	run(t, "make", "-C", "backends/dbmigrations", "setup")
	testfile.Copy(t, "../20240715145233_create_tasks.sql", "./backends/dbmigrations/20240715145233_create_tasks.sql")
	run(t, "make", "-C", "backends/dbmigrations") // Run build, lint, test

	// backends/biz
	run(t, "make", "-C", "backends/biz", "setup")
	run(t, "make", "-C", "backends/biz", "dump-schema-sql")
	testdir.MkdirAll(t, "backends/biz/queries")
	testfile.Copy(t, "../tasks.sql", "./backends/biz/queries/tasks.sql")
	testfile.Copy(t, "../sqlc.yaml", "./backends/biz/sqlc.yaml")
	run(t, "make", "-C", "backends/biz", "sqlc-generate")

	// backends/applib
	run(t, "make", "-C", "backends/applib")

	// backends/apisvr
	run(t, "make", "-C", "backends/apisvr", "setup")
	testdir.MkdirAll(t, "backends/apisvr/proto/task/v1")
	testfile.Copy(t, "../task.proto", "./backends/apisvr/proto/task/v1/task.proto")
	run(t, "make", "-C", "backends/apisvr/proto", "buf-dep-update")
	run(t, "make", "-C", "backends/apisvr/proto", "generate")
	testdir.MkdirAll(t, "backends/apisvr/services/task_service")
	testfile.Copy(t, "../task_service/task_service-go", "./backends/apisvr/services/task_service/task_service.go")
	// testfile.Copy(t, "../task_service/task_service_test-go", "./backends/apisvr/services/task_service/task_service_test.go")
	testfile.Copy(t, "../cmd/server/main-go", "./backends/apisvr/cmd/server/main.go")

	testdir.Cd(t, "backends/apisvr")
	run(t, "go", "get", "applib")
	run(t, "go", "get", "biz")
	run(t, "go", "get", "connectrpc.com/authn@v0.1.0")
	run(t, "go", "mod", "tidy")
	run(t, "make", "build", "lint", "test")

	if os.Getenv("GITHUB_ACTIONS") != "true" {
		teardown()
	}
}
