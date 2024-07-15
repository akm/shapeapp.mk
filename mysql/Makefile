include dsn.mk
include cli.mk

.PHONY: dsn
dsn:
	@echo "$(MYSQL_DSN)"

.PHONY: console
console:
	mysql $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME)
