articles := "content/articles"
lastpost := `find content/articles -maxdepth 1 -mindepth 1 -type f | sort -nr | head -1`
shortdate := `date -u '+%Y-%m-%d'`
docker_image := "mhoush.com"
docker_tag := "latest"

[private]
default:
  @just --list

# Run the development server.
[group('dev')]
run:
  @swift run watch content Sources deploy

# Run css, watching for changes.
[group('dev')]
run-css:
  @pnpm run css-watch

# Build docker image.
[group('dev')]
build-docker:
  @podman build -t {{docker_image}}:{{docker_tag}} -f docker/Dockerfile .

# Run docker image.
[group('dev')]
run-docker:
  @podman run --rm -it -p 8080:80 {{docker_image}}:{{docker_tag}}

alias pr := generate-pr

# Generate a new pull-request.
[group('dev')]
generate-pr:
  @gh pr create --base main --fill

# Merge a pull-request.
[group('dev')]
merge-pr *ARGS:
  @./scripts/pr-merge.sh {{ARGS}}

# Get the last modified article.
[group('blog')]
last-post:
  @echo {{lastpost}}

# Get the last post's base filename.
[group('blog')]
last-post-basename:
  @./scripts/last-post-basename.sh

# Generate a new post with the given file name.
[group('blog')]
new-post name:
  $EDITOR {{articles}}/{{shortdate}}-{{name}}.md

# Open canva to generate blog images.
[group('blog')]
open-canva:
  open https://www.canva.com/folder/FAFu50aO6nY

[group('dev')]
open-netlify:
	@brave "https://app.netlify.com/projects/extraordinary-kitten-2506eb/deploys"
