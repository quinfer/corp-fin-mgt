#!/bin/bash

# This script safely publishes the docs directory to GitHub Pages
# With additional safeguards to prevent accidental content loss

# Check for a clean working directory
if ! git diff-index --quiet HEAD --; then
  echo "[safe-publish.sh] ERROR: You have uncommitted changes. Please commit or stash your changes before running this script."
  git status
  exit 1
fi

echo "Starting safe publishing process..."

# First, stash any uncommitted changes to prevent conflicts
echo "Stashing any uncommitted changes..."
git stash -u || echo "No changes to stash"

# Make sure we're on the main branch
echo "Checking out main branch..."
git checkout main

# Make sure docs directory exists and has content
if [ ! -d "docs" ] || [ -z "$(ls -A docs)" ]; then
  echo "Error: docs directory doesn't exist or is empty!"
  echo "Run 'quarto render' commands first or check your directory structure."
  git stash pop || echo "No stashed changes"
  exit 1
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Copy all contents from docs to the temp directory
echo "Copying docs content to temporary directory..."
cp -r docs/* $TEMP_DIR/

# Count files to verify copy was successful
ORIGINAL_COUNT=$(find docs -type f | wc -l)
COPIED_COUNT=$(find $TEMP_DIR -type f | wc -l)
echo "Files in docs: $ORIGINAL_COUNT, Files in temp: $COPIED_COUNT"

# Allow for a small discrepancy in file counts (e.g., hidden files)
DIFF=$((ORIGINAL_COUNT - COPIED_COUNT))
if [ $DIFF -lt 0 ]; then
  DIFF=$((DIFF * -1))  # Get absolute value
fi

if [ $DIFF -gt 5 ]; then
  echo "Warning: There's a significant difference in file counts ($DIFF files)"
  echo "Do you want to continue anyway? (y/n)"
  read -r response
  if [[ ! $response =~ ^[Yy]$ ]]; then
    echo "Publishing aborted by user."
    rm -rf $TEMP_DIR
    git stash pop || echo "No stashed changes"
    exit 1
  fi
  echo "Continuing with publishing despite file count difference..."
else
  echo "File count difference is within acceptable range ($DIFF files)"
fi

# Switch to gh-pages branch
echo "Switching to gh-pages branch..."
if ! git checkout gh-pages; then
  echo "Error: Failed to switch to gh-pages branch!"
  rm -rf $TEMP_DIR
  git checkout main
  git stash pop || echo "No stashed changes"
  exit 1
fi

# Save current directory
CURRENT_DIR=$(pwd)
echo "Current directory: $CURRENT_DIR"

# Check if we're in the right place
if [[ "$CURRENT_DIR" != *corp-fin-mgt ]]; then
  echo "Error: Not in the expected directory!"
  git checkout main
  rm -rf $TEMP_DIR
  git stash pop || echo "No stashed changes"
  exit 1
fi

# Remove all files (except .git) - More carefully with feedback
echo "Removing existing files in gh-pages branch..."
find . -mindepth 1 -maxdepth 1 ! -name ".git" ! -name "." | while read file; do
  echo "  Removing: $file"
  rm -rf "$file"
done

# Copy the content from temp directory with progress feedback
echo "Copying website content from temporary directory to gh-pages branch..."
cp -rv $TEMP_DIR/* .

# Verify the copy was successful
GH_PAGES_COUNT=$(find . -type f -not -path "./.git/*" | wc -l)
echo "Files in gh-pages: $GH_PAGES_COUNT, Expected: $COPIED_COUNT"

# Allow for a small discrepancy here too
DIFF=$((GH_PAGES_COUNT - COPIED_COUNT))
if [ $DIFF -lt 0 ]; then
  DIFF=$((DIFF * -1))  # Get absolute value
fi

if [ $DIFF -gt 5 ]; then
  echo "Warning: There's a significant difference in gh-pages file count ($DIFF files)"
  echo "Do you want to continue anyway? (y/n)"
  read -r response
  if [[ ! $response =~ ^[Yy]$ ]]; then
    echo "Publishing aborted by user."
    git checkout main
    rm -rf $TEMP_DIR
    git stash pop || echo "No stashed changes"
    exit 1
  fi
  echo "Continuing with publishing despite file count difference..."
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit and push
echo "Committing changes..."
git commit -m "Update GitHub Pages content - $(date)" || echo "No changes to commit"

echo "Pushing to GitHub..."
git push origin gh-pages

# Return to main branch
echo "Switching back to main branch..."
git checkout main

# Remove temp directory
echo "Cleaning up..."
rm -rf $TEMP_DIR

# Restore any stashed changes
git stash pop || echo "No stashed changes"

echo "Process completed successfully."
echo "Your site should be available at: https://quinfer.github.io/corp-fin-mgt/"
echo "Note: It may take a few minutes for GitHub Pages to update the site." 