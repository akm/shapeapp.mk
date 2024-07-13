# Requires: 
# PATH_TO_PROTO=(path to proto directory)

gen:
	$(MAKE) generate

.PHONY: generate
generate:
	$(MAKE) -C $(PATH_TO_PROTO) generate
