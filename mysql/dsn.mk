# Required included files:
# - make/or.mk

MYSQL_LOCATION?=Asia%2FTokyo
MYSQL_OPTIONS?=charset=utf8mb4&parseTime=True&loc=$(MYSQL_LOCATION)
# MYSQL_DSN?=$(MYSQL_USER_NAME):$(MYSQL_USER_PASSWORD)@tcp($(MYSQL_HOST):$(MYSQL_PORT))/$(MYSQL_DB_NAME)?$(MYSQL_OPTIONS)

# $(1): host: default MYSQL_HOST
# $(2): port: default MYSQL_PORT
# $(3): user name: default MYSQL_USER_NAME
# $(4): password: default MYSQL_USER_PASSWORD
# $(5): db name: default MYSQL_DB_NAME
define mysql-build-dsn
$(call or,$(3),$(MYSQL_USER_NAME)):$(call or,$(4),$(MYSQL_USER_PASSWORD))@tcp($(call or,$(1),$(MYSQL_HOST)):$(call or,$(2),$(MYSQL_PORT)))/$(call or,$(5),$(MYSQL_DB_NAME))?$(MYSQL_OPTIONS)
endef

# mysql-dsn-from-outside について関数とターゲットの両方を同名で定義
define mysql-dsn-from-outside
$(call mysql-build-dsn,127.0.0.1,$(MYSQL_PORT))
endef
.PHONY: mysql-dsn-from-outside
mysql-dsn-from-outside:
	@echo '$(mysql-dsn-from-outside)'

# mysql-dsn-from-inside について関数とターゲットの両方を同名で定義
define mysql-dsn-from-inside
$(call mysql-build-dsn,$(MYSQL_HOST),3306)
endef
.PHONY: mysql-dsn-from-inside
mysql-dsn-from-inside:
	@echo '$(mysql-dsn-from-inside)'
