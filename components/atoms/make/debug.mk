# make debug V="FOO BAR" will show the value of FOO and BAR
.PHONY: debug-warning
debug-warning:
	$(foreach v,$(V), \
		$(warning $(v)=$($(v))) \
	)

.PHONY: debug
debug:
	@echo '$(foreach v,$(V),$(v)=$($(v)))'
