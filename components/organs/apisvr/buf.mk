# Optional variables: 
# - BUF_APP_GEN_PATH_TO_PROTO: default value is ./proto
#
# Defined targets:
# - buf-generate
# - generate
#
# Included .mk files:
# - buf/buf.mk

include $(PATH_TO_SHAPEAPPMK)/components/atoms/buf/buf.mk

BUF_APP_GEN_PATH_TO_PROTO?=./proto

.PHONY: buf-generate
buf-generate:
	$(MAKE) -C $(BUF_APP_GEN_PATH_TO_PROTO) generate

.PHONY: generate
generate: buf-generate
