# arguments:
# $(1): target
# $(2): Space separated directories
#
# example:
# $(call eachdir,install,$(DIRS))
define eachdir
	for dir in $(2); do \
		echo "make $(1) in $$dir"; \
		$(MAKE) -C $$dir $(1); \
	done
endef
