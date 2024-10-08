set -x

APPLICATION_DIR_NAME=$(basename $PWD)

if [ ! -d .git ]; then
  echo '🚨 git repository does not exist. Run "git init ."'
  exit 1
fi

echo "# ${APPLICATION_DIR_NAME}" > README.md 

## vendor/shapeappmk
git submodule add -b ${SHAPEAPPMK_BRANCH:-main} git@github.com:akm/shapeapp.mk.git vendor/shapeappmk

## backends/applib
git submodule add -b ${SHAPEAPP_APPLIB_BRANCH:-main} git@github.com:akm/shapeapp-applib.git backends/applib

## .config.mk
cat <<EOF > .config.mk
APP_BASE_NAME=${APPLICATION_DIR_NAME}
APP_MYSQL_DB_NAME=\$(APP_BASE_NAME)-db1
GOOGLE_CLOUD_PROJECT_LOCAL=\$(APP_BASE_NAME)-gcp-project1
APP_FIREBASE_API_KEY?=firebase-api-key-dummy1

CONFIG_VARS=APP_BASE_NAME APP_MYSQL_DB_NAME GOOGLE_CLOUD_PROJECT_LOCAL APP_FIREBASE_API_KEY
CONFIG_ENVS=\$(foreach v,\$(CONFIG_VARS),\$(v)=\$(\$(v)))
EOF

## .shapeapp.mk
cat <<EOF > .shapeapp.mk
include \$(PATH_TO_ROOT)/.config.mk

PATH_TO_SHAPEAPPMK=\$(PATH_TO_ROOT)/vendor/shapeappmk
include \$(PATH_TO_SHAPEAPPMK)/components/molecules/make/default.mk
include \$(PATH_TO_SHAPEAPPMK)/components/atoms/asdf/reshim.mk
include \$(PATH_TO_SHAPEAPPMK)/components/atoms/golang/tool.mk
include \$(PATH_TO_SHAPEAPPMK)/components/atoms/text-template-cli/base.mk
include \$(PATH_TO_SHAPEAPPMK)/default/app_stage.mk
include \$(PATH_TO_SHAPEAPPMK)/default/ports.mk
include \$(PATH_TO_SHAPEAPPMK)/default/directories.mk
EOF

## Makefile
cat <<EOF > Makefile
PATH_TO_ROOT=.
include \$(PATH_TO_ROOT)/.shapeapp.mk
include \$(PATH_TO_SHAPEAPPMK)/default/setup.mk
EOF
