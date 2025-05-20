#!/bin/bash
# reliable-publish.sh - A robust script for publishing to GitHub Pages
# Usage: ./reliable-publish.sh [--no-build]

set -e  # Exit on any error

# Change to the project root directory regardless of where the script is called from
cd "$(dirname "$0")/.."
PROJECT_ROOT=$(pwd)
echo "Running from project root: $PROJECT_ROOT"

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

# Store the current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"

# Build the website first unless --no-build is specified
if [ "$NO_BUILD" = false ]; then
  echo "Building the website..."
  ./_scripts/render-website.sh --clean
fi

# Validate the build
echo "Validating the build..."
./_scripts/validate-site.sh || true  # Continue even if validation has warnings

# Add a timestamp file to force cache refresh
echo "Adding build timestamp..."
DATE=$(date)
echo "Last built: $DATE" > docs/build-timestamp.txt

# Create a .nojekyll file to prevent GitHub Pages from using Jekyll
echo "Ensuring .nojekyll file exists..."
touch docs/.nojekyll

# Commit any changes to current branch
echo "Committing any changes to $CURRENT_BRANCH branch..."
git add docs/
git commit -m "Update website: $DATE" || echo "No changes to commit in $CURRENT_BRANCH"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Copy the docs/ directory to the temporary directory
echo "Copying docs/ to temporary directory..."
cp -r docs/* $TEMP_DIR/
cp -r docs/.nojekyll $TEMP_DIR/ 2>/dev/null || true

# Save the current state
git stash -u || true  # Stash all changes including untracked files

# Switch to or create the gh-pages branch
if git show-ref --verify --quiet refs/heads/gh-pages; then
  echo "Checking out existing gh-pages branch..."
  git checkout gh-pages
else
  echo "Creating new gh-pages branch..."
  git checkout --orphan gh-pages
  git rm -rf . || true
fi

# Clear out the current gh-pages branch content
echo "Clearing current gh-pages branch content..."
find . -maxdepth 1 ! -path "./.git" ! -path "." -exec rm -rf {} \;

# Copy the files from the temporary directory to the current directory
echo "Copying files from temporary directory to gh-pages branch..."
cp -r $TEMP_DIR/* .
cp -r $TEMP_DIR/.* . 2>/dev/null || true

# Add all files and commit
echo "Adding and committing files to gh-pages branch..."
git add -A
git commit -m "Update GitHub Pages website: $DATE" || echo "No changes to commit in gh-pages"

# Force push to gh-pages
echo "Force-pushing gh-pages branch to remote..."
git push -f origin gh-pages

# Clean up temporary directory
echo "Cleaning up temporary directory..."
rm -rf $TEMP_DIR

# Switch back to the original branch
echo "Switching back to $CURRENT_BRANCH branch..."
git checkout $CURRENT_BRANCH

# Pop the stash if we stashed anything
if git stash list | grep -q "stash@{0}"; then
  echo "Popping stashed changes..."
  git stash pop
fi

echo "Website published successfully!"
echo "Visit https://quinfer.github.io/corp-fin-mgt/ to view your site."
echo "Note: It may take a few minutes for GitHub Pages to update."
