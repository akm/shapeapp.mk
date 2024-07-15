# Requires:
# PATH_TO_PROTO?=...

.PHONY: connect-web-generate
connect-web-generate:
	$$SHELL -c 'npx buf generate $(PATH_TO_PROTO)/**/*.proto'
# make can't treat asterisk as a wildcard, so we need to use shell to expand it
