.PHONY: build
build:
	@hugo --cleanDestinationDir --gc

.PHONY: serve
serve:
	@hugo server --buildDrafts --disableFastRender

.PHONY: pr
pr:
	gh pr create --base main --fill
