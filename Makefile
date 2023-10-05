.PHONY: build
build:
	@hugo --cleanDestinationDir --gc

.PHONY: serve
serve:
	@hugo server --buildDrafts --disableFastRender

.PHONY: pr
pr:
	gh pr create --base main --fill

.PHONY: pr-merge
pr-merge:
	source scripts/pr-merge.sh
