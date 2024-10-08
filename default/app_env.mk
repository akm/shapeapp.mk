## APP_ENV
#
# (正確に言えば process cluster type みたいな名前のはずですが分かりやすい名前じゃないので APP_ENV にしました)
#
# APP_ENV | 起動するプロセス群
# ---------|------------------
# - server | uisvr, apisvr
# - dev     | uisvr, apisvr, mysql, firebase_auth
# - e2e_test | uisvr, apisvr, mysql, firebase_auth, frontends/uisvr/tests
# - unit_test | uisvr のテスト( frontends/uisvr/tests 以外), servers 以下のテスト, mysql, firebase_auth
#
# この環境変数は、Makefie で処理を開始する際に設定します。
# つまりmakeのターゲットの実行時にのみ決定するので、静的に指定するものではありません。
