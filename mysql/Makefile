include dsn.mk
include cli.mk

.PHONY: dsn
dsn:
	@echo "$(MYSQL_DSN)"

.PHONY: console
console:
	mysql $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME)

WAIT_RETRY_TIMES?=3

.PHONY: wait
wait:
	@until (mysqladmin $(MYSQL_CLI_OPTS) ping &>/dev/null) do echo 'waiting mysql connection.' && sleep 1; done

# MYSQLDUMP_OPTS?=--no-data
DUMP_OPTS?=
DUMP_DEST?=
DUMP_USE_GZIP?=
ifeq ($(DUMP_DEST),)
DUMP_POST_PROCESS?=
else ifeq ($(DUMP_USE_GZIP),)
DUMP_POST_PROCESS?=> $(DUMP_DEST)
else
DUMP_POST_PROCESS?=| gzip > $(DUMP_DEST)
endif

.PHONY: dump
dump:
	mysqldump $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME) $(DUMP_OPTS) $(DUMP_POST_PROCESS)
