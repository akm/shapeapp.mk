include dsn.mk
include cli.mk

.PHONY: dsn
dsn:
	@echo "$(MYSQL_DSN)"

.PHONY: console
console:
	mysql $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME)

WAIT_INITIAL_SECONDS?=1
WAIT_RETRY_TIMES?=3

.PHONY: wait
wait:
	sleep $(WAIT_INITIAL_SECONDS) && mysqladmin -u root -h 127.0.0.1 --wait --count $(WAIT_RETRY_TIMES) ping || exit 1


# MYSQLDUMP_OPTS?=--no-data
DUMP_OPTS?=
DUMP_DEST?=
DUMP_USE_GZIP?=
ifeq ($(DUMP_DEST),)
DUMP_POST_PROCESS=
else ifeq ($(DUMP_USE_GZIP),)
DUMP_POST_PROCESS=> $(DUMP_DEST)
else
DUMP_POST_PROCESS=| gzip > $(DUMP_DEST)
endif

.PHONY: dump
dump:
	mysqldump $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME) $(DUMP_OPTS) $(DUMP_POST_PROCESS)
