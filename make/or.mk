# $(1) value
# $(2) default value
define or
ifeq ($(1),)
$(2)
else
$(1)
endif
endef
