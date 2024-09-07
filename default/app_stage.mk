# ## APP_STAGE_TYPE
#
# サーバーを動かす環境を総称して APP_STAGE と呼びます。
# APP_STAGE には以下の４つの種類が想定され、APP_STAGE_TYPE と呼びます。
#
# - production
# - staging
# - localdev
# - localtest
# - dev

APP_STAGE_TYPE?=dev

# ## APP_STAGE
#
# APP_STAGE_TYPE のインスタンスとして APP_STAGE が複数個存在し、
# リポジトリにそれらの違いをコミットしなければならない場合もありえます。
# 例えば staging に対して staging1, staging2 それぞれで設定が
# 異なる場合が考えられます。
# 逆に localdev のインスタンスとして各開発者の環境はそれぞれ別物ですが、
# それらの違いをコミットする必要がなければ localdev1, localdev2 という
# ような Stage を登録する必要はありません。
# ただし APP_STAGE_TYPE として localdev_windows と  localdev_mac 
# のような区別を行った方が良い場合も考えられます。
#
# ### 例
#
# - production1
# - staging1
# - staging2
# - localdev
# - localtest
# - dev

# localdev, localtest については APP_STAGE は APP_STAGE_TYPE と同一です。
# デプロイ対象である production や staging では APP_STAGE は APP_STAGE_TYPE
# と異なり、staging1 などの具体的なステージ名を指定します。
ifeq ($(APP_STAGE_TYPE),dev)
APP_STAGE?=$(APP_STAGE_TYPE)
else ifeq ($(APP_STAGE_TYPE),local)
APP_STAGE?=$(APP_STAGE_TYPE)
else ifeq ($(APP_STAGE_TYPE),localtest)
APP_STAGE?=$(APP_STAGE_TYPE)
else
APP_STAGE?=$(APP_STAGE_TYPE)1
endif
