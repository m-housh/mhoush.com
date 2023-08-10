build:
	@hugo --cleanDestinationDir --gc

serve:
	@hugo server --buildDrafts --disableFastRender
