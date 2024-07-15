.PHONY: goose-create
goose-create:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' create $(GOOSE_MIGRATION_NAME) sql

.PHONY: goose-create-go
goose-create-go:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' create $(GOOSE_MIGRATION_NAME) go
