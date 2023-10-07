.PHONY: build
build:
	@hugo --cleanDestinationDir --gc -b http://localhost:1414

.PHONY: serve
serve:
	@hugo server --buildDrafts --disableFastRender

.PHONY: serve-with-search
serve-with-search: build
	@npx -y pagefind --site public --serve

.PHONY: pr
pr:
	gh pr create --base main --fill
