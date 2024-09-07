# $(call shell-dir-target-vars,prefix,dir,targets)
define shell-dir-target-vars
	$(eval
		$(foreach target,$(3),
			$(eval $(2)$(target)=$$(shell $(MAKE) -C $(1) $(target) --no-print-directory))
		)
	)
endef
