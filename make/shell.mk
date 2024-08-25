# $(call shell-dir-target-vars,prefix,dir,targets)
define shell-dir-target-vars
	$(eval
		$(foreach target,$(3),
			$(eval $(1)$(target)=$$(shell $(MAKE) -C $(2) $(target) --no-print-directory))
		)
	)
endef
