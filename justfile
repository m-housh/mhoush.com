shortdate := `date -u '+%Y-%m-%d'`
articles := "content/articles"

[private]
default:
  @just --list

# Run the development server.
[group('dev')]
run:
  @swift run watch content Sources deploy

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
  @echo "$(find content/articles -maxdepth 1 -mindepth 1 -type f -ctime -30 | sort -nr | head -1)"

# Generate a new post with the given file name.
[group('blog')]
new-post name:
  $EDITOR {{articles}}/{{shortdate}}-{{name}}.md
