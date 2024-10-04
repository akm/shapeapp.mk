# shapeapp.mk

## アプリケーションの作り方

1. mkdir -p アプリケーション名
1. cd $_
1. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/features/application_setup_document/scripts/install.sh)
1. make setup
1. backends/dbmigrations のセットアップ
    1. make -C backends/dbmigrations setup
    2. backends/dbmigrations にテーブルを追加する SQLを追加
    1. make -C backends/dbmigrations new create_(テーブル名)
    2. 生成されたファイルに CREATE TABLE と DROP TABLE を追加
    3. make -C backends/dbmigrations
1. backends/biz のセットアップ
    1. make -C backends/biz setup
    2. backends/biz にクエリを定義
    3. make -C backends/biz dump-schema-sql
    4. [sqlcのドキュメント](https://docs.sqlc.dev/en/stable/tutorials/getting-started-mysql.html) を参考に backends/biz/queries/(テーブル名).sql を作成
    5. backends/biz/sqlc.yaml の queries をコメントアウト
    6. make -C backends/biz sqlc-generate


## よく使う make ターゲットの名前

- install-dev-deps
- install-deps
- build-setup
- build
- lint
- test
