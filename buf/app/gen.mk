# Requires: 
# PATH_TO_PROTO=(path to proto directory)

.PHONY: buf-generate
buf-generate:
	$(MAKE) -C $(PATH_TO_PROTO) generate
