.PHONY: connect-web-install
connect-web-install:
	npm install && \
	npm install --save-dev @bufbuild/buf @connectrpc/protoc-gen-connect-es @bufbuild/protoc-gen-es && \
	npm install @connectrpc/connect @connectrpc/connect-web @bufbuild/protobuf
