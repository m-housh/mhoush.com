MERGE := ""

.PHONY: build
build:
	@hugo --cleanDestinationDir --gc

.PHONY: serve
serve:
	@hugo server --buildDrafts --disableFastRender

.PHONY: pull-request
pull-request:
	gh pr create --base main --fill

.PHONY: pr
pr: pull-request

.PHONY: pr-merge
pr-merge:
	gh pr merge --merge "$(MERGE)"
