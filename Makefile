.PHONY: build
build:
	@hugo --cleanDestinationDir --gc

.PHONY: serve
serve:
	@hugo server --buildDrafts --disableFastRender

.PHONY: pr
pr: pull-request

.PHONY: pr-merge
pr-merge:
	source scripts/pr-merge.sh
