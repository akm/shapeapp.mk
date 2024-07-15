GOOSE_COMMAND=$(GOOSE_ENVS) go run $(GOOSE_MAIN_PACKAGE) '$(GOOSE_DSN)'

.PHONY: goose-create
goose-create:
	$(GOOSE_COMMAND) create $(GOOSE_MIGRATION_NAME) sql

.PHONY: goose-create-go
goose-create-go:
	$(GOOSE_COMMAND) create $(GOOSE_MIGRATION_NAME) go

.PHONY: goose-up
goose-up:
	$(GOOSE_COMMAND) up

.PHONY: goose-down
goose-down:
	$(GOOSE_COMMAND) down

.PHONY: goose-state
goose-state: 
	$(GOOSE_COMMAND) status

.PHONY: goose-reset
goose-reset: 
	$(GOOSE_COMMAND) reset
