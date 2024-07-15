.PHONY: goose-create
goose-create:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' create $(GOOSE_MIGRATION_NAME) sql

.PHONY: goose-create-go
goose-create-go:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' create $(GOOSE_MIGRATION_NAME) go

.PHONY: goose-up
goose-up:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' up

.PHONY: goose-down
goose-down:
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' down

.PHONY: goose-state
goose-state: 
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' status

.PHONY: goose-reset
goose-reset: 
	go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)' reset
