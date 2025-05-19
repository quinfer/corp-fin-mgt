#!/bin/bash
# publish.sh - Script for publishing the website to GitHub Pages
# Usage: ./publish.sh [--no-build]

set -e  # Exit on any error

# Process arguments
NO_BUILD=false
for arg in "$@"; do
  case $arg in
    --no-build)
      NO_BUILD=true
      shift
      ;;
  esac
done

# Get the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

# Build the website first unless --no-build is specified
if [ "$NO_BUILD" = false ]; then
  echo "Building the website..."
  ./_scripts/render-website.sh --clean
fi

# Validate the build
echo "Validating the build..."
./_scripts/validate-site.sh

# Add a timestamp file to force cache refresh
echo "Adding build timestamp..."
echo "Last built: $(date)" > docs/build-timestamp.txt

# Commit the changes to the docs folder
echo "Committing changes to docs folder..."
git add docs/
git commit -m "Update website: $(date)" || echo "No changes to commit"

# Create gh-pages branch if it doesn't exist
if ! git show-ref --quiet refs/heads/gh-pages; then
  echo "Creating gh-pages branch..."
  git checkout --orphan gh-pages
  git rm -rf .
  echo "# Corporate Financial Management Website" > README.md
  git add README.md
  git commit -m "Initial gh-pages branch"
  git push origin gh-pages
  git checkout "$current_branch"
fi

# Push to gh-pages branch
echo "Pushing to gh-pages branch..."
git subtree push --prefix docs origin gh-pages

echo "Website published successfully!"
echo "Visit https://quinfer.github.io/corp-fin-mgt/ to view your site."
