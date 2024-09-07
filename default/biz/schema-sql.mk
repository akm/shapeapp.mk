# Required variables:
#   - PATH_TO_SHAPEAPPMK
#
# Optional variables:
#   - SCHEMA_SQL
#   - BIZ_PATH_TO_TEST_CONTAINERS

SCHEMA_SQL?=schema.sql
$(SCHEMA_SQL): dump-schema-sql

BIZ_PATH_TO_TEST_CONTAINERS?=../test/containers

# test-containers-up
# test-containers-down
test-containers-%:
	$(MAKE) -C ../test/containers $*

# TEST_CONTAINERS-mysql-envs
$(call shell-dir-target-vars,$(BIZ_PATH_TO_TEST_CONTAINERS),TEST_CONTAINERS-,mysql-envs)

.PHONY: dump-schema-sql
dump-schema-sql: \
	test-containers-down \
	test-containers-up \
	dump-schema-sql-impl \
	test-containers-down

.PHONY: dump-schema-sql-impl
dump-schema-sql-impl:
	$(TEST_CONTAINERS-mysql-envs) \
	DUMP_OPTS=--no-data \
	DUMP_POST_PROCESS='| grep -v "Dump completed on" > $(abspath $(SCHEMA_SQL))' \
	$(MAKE) -C $(PATH_TO_SHAPEAPPMK)/mysql dump
