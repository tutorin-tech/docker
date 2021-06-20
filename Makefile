.PHONY: tit-api tit-rpc-server tit-theme tit-web-client

tit-api tit-rpc-server tit-theme tit-web-client:
	@docker build --no-cache \
	    -f $@/Dockerfile \
	    -t $@ .
