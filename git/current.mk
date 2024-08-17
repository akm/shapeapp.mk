GIT_CURRENT_COMMIT_HASH_SHORT=$(shell git show --format='%h' --no-patch)
.PHONY: git-current-commit-hash-short
git-current-commit-hash-short:
	@echo $(GIT_CURRENT_COMMIT_HASH_SHORT)
