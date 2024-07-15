ifeq (show-vars,$(firstword $(MAKECMDGOALS)))
  TARGET_VARS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(TARGET_VARS):;@:)
endif
.PHONY: show-vars
show-vars:
	@echo '$(foreach v,$(TARGET_VARS),$($(v)))'
