build:
	@hugo --cleanDestinationDir --gc

serve:
	@hugo server --buildDrafts --disableFastRender

pull-request:
	gh pr create --base main --fill

pr: pull-request
