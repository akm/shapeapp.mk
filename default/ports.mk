# ## APP_PORT
#
# APP_ENV                        | APP_STAGE_TYPE           | rproxy | apisvr | ui   | mysql | firebase authentication
# -------------------------------|--------------------------|--------|--------|------|-------|-------------------------
# server                         | staging,production       | 8000   | 8080   | 4173 | 3306  | ?
# dev                            | local                    | 8000   | 8080   | 5173 | 3306  | 9099
# clients/uisvr/test:integration | staging,production       | 8000   | 8080   | 4173 | 3306  | ?
# clients/uisvr/test:integration | local,github             | 8001   | 8081   | 4173 | 3307  | 9090
# clients/uisvr/test:unit        | local,github             | -      | -      | -    | -     | -
# servers/apisvr/test            | local,github             | -      | -      | -    | 3311  | 9091

APP_PORT_RPROXY_dev=8000
APP_PORT_RPROXY_e2e_test=8001
APP_PORT_APISVR_dev?=8080
APP_PORT_APISVR_e2e_test?=8001
APP_PORT_UISVR_dev?=5173
APP_PORT_UISVR_e2e_test?=4173
APP_PORT_MYSQL_dev?=3306
APP_PORT_MYSQL_e2e_test?=3307
APP_PORT_MYSQL_unit_test?=3311
APP_PORT_FIREBASE_AUTH_dev?=9099
APP_PORT_FIREBASE_AUTH_e2e_test?=9090
APP_PORT_FIREBASE_AUTH_unit_test?=9091
APP_PORT_FIREBASE_EMULATOR_SUITE_dev?=4000
