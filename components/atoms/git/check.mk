.PHONY: git-check
git-check: git-check-uncommited-changes git-check-untracked-files

.PHONY: git-check-uncommited-changes
git-check-uncommited-changes:
	@git diff --exit-code > /dev/null && \
		echo "no uncommited changes" || \
		( echo "uncommited changes exists" && git diff && exit 1 )

GIT_CHECK_UNTRACKED_FILES := $(shell git ls-files . --exclude-standard --others)

.PHONY: git-check-untracked-files
git-check-untracked-files:
	@if [ "$(GIT_CHECK_UNTRACKED_FILES)" = "" ]; then \
	  echo "No untracked file" ; \
	else \
	  echo "There is untracked file(s): $(GIT_CHECK_UNTRACKED_FILES)" && git status && exit 1 ; \
	fi
