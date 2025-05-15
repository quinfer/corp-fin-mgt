#!/bin/bash

# Extremely simple script to publish to GitHub Pages
# This avoids all the complexities by just using git commands directly

# Make sure we're on the main branch
git checkout main

# Commit any changes
git add .
git commit -m "Update files" || echo "No changes to commit"
git push origin main

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Copy the docs directory to the temp directory
cp -r docs/* $TEMP_DIR/

# Switch to gh-pages branch
git checkout gh-pages

# Remove all files (except .git)
find . -mindepth 1 -maxdepth 1 ! -name .git -exec rm -rf {} \;

# Copy the content back
cp -r $TEMP_DIR/* .

# Add all files
git add .

# Commit and push
git commit -m "Update GitHub Pages" || echo "No changes to commit"
git push origin gh-pages

# Return to main branch
git checkout main

# Remove temp directory
rm -rf $TEMP_DIR

echo "Website published to https://quinfer.github.io/corp-fin-mgt/" 