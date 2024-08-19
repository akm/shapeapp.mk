# Optional variables: 
# - BUF_APP_GEN_PATH_TO_PROTO: default value is ./proto

BUF_APP_GEN_PATH_TO_PROTO?=./proto

.PHONY: buf-generate
buf-generate:
	$(MAKE) -C $(BUF_APP_GEN_PATH_TO_PROTO) generate
