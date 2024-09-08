ifeq ($(MYSQL_USER_PASSWORD),)
MYSQL_CLI_AUTH_OPTS?=-u $(MYSQL_USER_NAME)
else
MYSQL_CLI_AUTH_OPTS?=-u $(MYSQL_USER_NAME) --password=$(MYSQL_USER_PASSWORD)
endif
MYSQL_CLI_OPTS=-h 127.0.0.1 -P $(MYSQL_PORT) $(MYSQL_CLI_AUTH_OPTS)

.PHONY: mysql-wait
mysql-wait:
ifdef GITHUB_ACTION
	sleep 10
endif
	until (mysqladmin $(MYSQL_CLI_OPTS) ping &>/dev/null) do echo 'waiting mysql connection.' && sleep 1; done

.PHONY: mysql-console
mysql-console:
	mysql $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME)

# MYSQL_DUMP_OPTS?=--no-data
MYSQL_DUMP_OPTS?=
MYSQL_DUMP_DEST?=
MYSQL_DUMP_USE_GZIP?=
ifeq ($(MYSQL_DUMP_DEST),)
MYSQL_DUMP_POST_PROCESS?=
else ifeq ($(MYSQL_DUMP_USE_GZIP),)
MYSQL_DUMP_POST_PROCESS?=> $(MYSQL_DUMP_DEST)
else
MYSQL_DUMP_POST_PROCESS?=| gzip > $(MYSQL_DUMP_DEST)
endif

.PHONY: mysql-dump
mysql-dump:
	mysqldump $(MYSQL_CLI_OPTS) $(MYSQL_DB_NAME) $(MYSQL_DUMP_OPTS) $(MYSQL_DUMP_POST_PROCESS)
