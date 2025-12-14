# Optional variables:
#   - VERSION_FILE (default version/version.go)
#   - VERSION_CONST_NAME (default Version)
VERSION_FILE?=version/version.go
VERSION_CONST_NAME?=Version

VERSION=$(shell grep $(VERSION_CONST_NAME) $(VERSION_FILE) | cut -f 2 -d '"')
.PHONY: version
version:
	@echo $(VERSION)
