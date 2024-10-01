.PHONY: connect-web-install
connect-web-install: npm-install connect-web-install-dev-deps connect-web-install-deps

.PHONY: connect-web-install-dev-deps
connect-web-install-dev-deps:
	npm install --save-dev @bufbuild/buf @connectrpc/protoc-gen-connect-es @bufbuild/protoc-gen-es

.PHONY: connect-web-install-deps
connect-web-install-deps:
	npm install @connectrpc/connect @connectrpc/connect-web @bufbuild/protobuf
