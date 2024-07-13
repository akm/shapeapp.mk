# PATH_TO_ROOT が各Makefile で設定されている前提
PATH_TO_BACKENDS?=$(PATH_TO_ROOT)/backends
PATH_TO_APISVR?=$(PATH_TO_BACKENDS)/apisvr
PATH_TO_APPLIB?=$(PATH_TO_BACKENDS)/applib
PATH_TO_BIZ?=$(PATH_TO_BACKENDS)/biz
PATH_TO_DBMIGRATIONS?=$(PATH_TO_BACKENDS)/dbmigrations

PATH_TO_STAGES=$(PATH_TO_ROOT)/stages
PATH_TO_LOCAL=$(PATH_TO_STAGES)/local
PATH_TO_LOCALDEV?=$(PATH_TO_LOCAL)/dev
PATH_TO_LOCALTEST?=$(PATH_TO_LOCAL)/test

PATH_TO_FRONTENDS?=$(PATH_TO_ROOT)/frontends
PATH_TO_UISVR?=$(PATH_TO_FRONTENDS)/uisvr
