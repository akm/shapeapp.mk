# shapeapp.mk

## アプリケーションの作り方

( コマンドの実行には [git-exec](https://github.com/akm/git-exec) を使うことをお勧めします )

1. mkdir -p アプリケーション名
1. cd $_
1. git init .
2. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/features/application_setup_document/scripts/install.sh)"
3. make setup
4. backends/dbmigrations のセットアップ
    1. make -C backends/dbmigrations setup
    2. backends/dbmigrations にテーブルを追加する SQLを追加
       1. make -C backends/dbmigrations new create_(テーブル名)
       2. [pressly/goose - SQL file annotations](https://pressly.github.io/goose/documentation/annotations/) を参考に、生成されたファイルに CREATE TABLE と DROP TABLE を追加
    3. make -C backends/dbmigrations
5. backends/biz のセットアップ
    1. make -C backends/biz setup
    2. make -C backends/biz dump-schema-sql
    3. [sqlcのドキュメント](https://docs.sqlc.dev/en/stable/tutorials/getting-started-mysql.html) を参考に backends/biz/queries/(テーブル名).sql を作成
    4. backends/biz/sqlc.yaml の queries をコメントアウトして queries/(テーブル名).sql を追加
    5. make -C backends/biz sqlc-generate
6. backends/applib の動作確認
    1. make -C backends/applib
7. backends/apisvr のセットアップ
    1. make -C backends/apisvr setup
    2. backends/apisvr/proto 以下にディレクトリを作成し .proto を配置
    3. make -C backends/apisvr/proto buf-dep-update
    4. make -C backends/apisvr/proto generate
    5. サービスを実装
    6. apisvr/cmd/server/main.go にサービスを組み込み
    7. make -C backends/apisvr build lint test

## よく使う make ターゲットの名前

- install-dev-deps
- install-deps
- build-setup
- build
- lint
- test
