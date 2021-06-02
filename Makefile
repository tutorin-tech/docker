.PHONY: tit-rpc-server tit-web-client

tit-rpc-server tit-web-client:
	@docker build --no-cache \
	    -f $@/Dockerfile \
	    -t $@ .
