# ## APP_STAGE_TYPE
#
# - production
# - staging
# - local
# - github
#
# APP_STAGE_TYPE のインスタンスとして STAGE が複数個存在し、リポジトリにそれらの違いをコミットしなければならない場合もありえます。
# 例えば staging に対して staging1, staging2 それぞれで設定が異なる場合が考えられます。
# 逆に local のインスタンスとして各開発者の環境はそれぞれ別物ですが、それらの違いをコミットする必要がなければ local1, local2
# というような Stage を登録する必要はありませんし、通常はそのように行うべきではありません。
# ただし APP_STAGE_TYPE として local_windows と  local_mac のような区別を行った方が良い場合もあります。
#
# ## APP_STAGE の例
#
# - production
# - staging1
# - staging2
# - local
# - github

ifeq ($(GITHUB_ACTIONS),true)
APP_STAGE_TYPE?=github
else
APP_STAGE_TYPE?=local
endif

# local, github では STAGE は APP_STAGE_TYPE と同一です。デプロイ対象である production や
# staging では STAGE は APP_STAGE_TYPE と異なり、staging1 などの具体的なステージ名を指定します。
ifeq ($(APP_STAGE_TYPE),local)
APP_STAGE?=$(APP_STAGE_TYPE)
else ifeq ($(APP_STAGE_TYPE),github)
APP_STAGE?=$(APP_STAGE_TYPE)
else
APP_STAGE?=$(APP_STAGE_TYPE)1
endif
