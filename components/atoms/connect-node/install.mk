.PHONY: connect-node-install
connect-node-install: npm-install connect-node-install-deps

# .PHONY: connect-node-install-dev-deps
# connect-node-install-dev-deps:

.PHONY: connect-node-install-deps
connect-node-install-deps:
	npm install @connectrpc/connect @connectrpc/connect-node
