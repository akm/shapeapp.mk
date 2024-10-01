# shapeapp.mk

## アプリケーションの作り方

1. mkdir -p アプリケーション名
2. cd $_
3. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/features/application_setup_document/scripts/install.sh)
4. make setup


## よく使う make ターゲットの名前

- install-dev-deps
- install-deps
- build-setup
- build
- lint
- test
