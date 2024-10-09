#!/usr/bin/env fish

# Fill vars for building the URL from git
set REPO_URL (
  git remote get-url origin | \
  sed 's/git@github.com:/https:\/\/github.com\//' | \
  sed 's/.git$//'
)
set BRANCH (git branch --show-current)
set FILE_PATH (realpath --relative-to=(git rev-parse --show-toplevel) "$argv[1]")

# Construct the url
set GITHUB_LINK "$REPO_URL/blob/$BRANCH/$FILE_PATH#L1"

# Copy it to clipboard
echo $GITHUB_LINK | win32yank.exe -i

echo "GitHub link copied to clipboard: $GITHUB_LINK"
