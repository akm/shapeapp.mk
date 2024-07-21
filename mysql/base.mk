.PHONY: mysql-envs
mysql-envs:
	@echo '$(MYSQL_ENVS)'

MYSQL_DSN=$(shell $(MYSQL_ENVS) $(MAKE) -C $(PATH_TO_SHAPEAPPMK)/mysql dsn --no-print-directory)

.PHONY: mysql-dsn
mysql-dsn:
	@echo '$(MYSQL_DSN)'

.PHONY: mysql-wait
mysql-wait:
	$(MYSQL_ENVS) $(MAKE) -C $(PATH_TO_SHAPEAPPMK)/mysql wait

.PHONY: mysql-console
mysql-console:
	$(MYSQL_ENVS) $(MAKE) -C $(PATH_TO_SHAPEAPPMK)/mysql console
