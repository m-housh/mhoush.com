articles := "content/articles"
lastpost := `find content/articles -maxdepth 1 -mindepth 1 -type f | sort -nr | head -1`
shortdate := `date -u '+%Y-%m-%d'`

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
