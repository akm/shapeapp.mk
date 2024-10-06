# shapeapp.mk

## アプリケーションの作り方

### 必須条件

- MacOS or Linux
    - Windows ならば WSL2 でいけるはず
- [git](https://git-scm.com/)
- [asdf](https://asdf-vm.com/)

### 手順

( コマンドの実行には [git-exec](https://github.com/akm/git-exec) を使うことをお勧めします )

1. mkdir -p アプリケーション名
1. cd $_
1. git init .
2. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akm/shapeapp.mk/refs/heads/main/scripts/install.sh)"
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
    8. ローカルでの動作確認
        1. make -C backends/apisvr dev-containers-up
        2. make -C backends/dbmigrations up
        3. make -C backends/apisvr dev
        4. [svelte-connect-todo の test-connections.sh](https://github.com/akm/svelte-connect-todo/blob/435458e3d7895babbe355972dc5f5f62cc3a92d0/backends/apisvr/proto/test-connections.sh) を参考に backends/apisvr/proto に test-connections.sh を追加
        5. 別のターミナルで実行
           1. cd backends/apisvr/proto
           2. make build
           3. APISVR_ORIGIN=http://localhost:8080 ./test-connections.sh
1. frontends/uisvr のセットアップ
    1. make -C frontends uisvr
        1. (npx init sveltekit@latest が実行されます)
        2. `Skeleton project` を選択
        3. `Yes, using TypeScript syntax` を選択
        4. 以下をすべて選択
            - `Add ESLint for code linting`
            - `Add Prettier for code formatting`
            - `Add Playwright for browser testing`
            - `Add Vitest for unit testing`
    2. make -C frontends/uisvr generate
    3. frontends/uisvr/src/routes/+page.svelte 等を実装
        - 必要に応じてライブラリをインストールしてください
        - [SvelteKit日本語ドキュメント](https://kit.svelte.jp/)
        - [SvelteKit公式ドキュメント](https://kit.svelte.dev/)
    4. サーバーを起動
        - make -C frontends/uisvr dev
        - 表示されたURLをブラウザで開く
