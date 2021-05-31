.PHONY: tit-web-client

tit-web-client:
	@docker build --no-cache \
	    -f $@/Dockerfile \
	    -t $@ .
