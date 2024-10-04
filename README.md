# shapeapp.mk

## アプリケーションの作り方

1. mkdir -p アプリケーション名
1. cd $_
1. git init .
1. echo "# アプリケーション名" > README.md
1. git add README.md
1. git commit -m '🎉 Initial commit'
1. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/features/application_setup_document/scripts/install.sh)
1. make setup
1. backends/dbmigrations のセットアップ
    1. make -C backends/dbmigrations setup
    1. backends/dbmigrations にテーブルを追加する SQLを追加
    1. make -C backends/dbmigrations new create_(テーブル名)
    1. 生成されたファイルに CREATE TABLE と DROP TABLE を追加
    1. make -C backends/dbmigrations
1. backends/biz のセットアップ
    1. make -C backends/biz setup
    1. backends/biz にクエリを定義
    1. make -C backends/biz dump-schema-sql
    1. [sqlcのドキュメント](https://docs.sqlc.dev/en/stable/tutorials/getting-started-mysql.html) を参考に backends/biz/queries/(テーブル名).sql を作成
    1. backends/biz/sqlc.yaml の queries をコメントアウト
    1. make -C backends/biz sqlc-generate
1. backends/applib のセットアップ
    1. make -C backends/applib setup
1. backends/apisvr のセットアップ
    1. make -C backends/apisvr setup
    1. backends/apisvr/proto 以下にディレクトリを作成し .proto を配置
    1. make -C backends/apisvr/proto buf-dep-update
    1. make -C backends/apisvr/proto generate
    1. サービスを実装
    1. apisvr/cmd/server/main.go にサービスを組み込み

## よく使う make ターゲットの名前

- install-dev-deps
- install-deps
- build-setup
- build
- lint
- test
