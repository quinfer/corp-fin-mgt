#!/bin/bash

# This script fixes the gh-pages branch by carefully copying the content from docs directory

echo "Starting process to fix gh-pages branch..."

# Make sure we're on the main branch
echo "Checking out main branch..."
git checkout main

# Make sure docs directory exists and has content
if [ ! -d "docs" ] || [ -z "$(ls -A docs)" ]; then
  echo "Error: docs directory doesn't exist or is empty!"
  exit 1
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Copy all contents from docs to the temp directory
echo "Copying docs content to temporary directory..."
cp -r docs/* $TEMP_DIR/

# Check if the copy worked
if [ -z "$(ls -A $TEMP_DIR)" ]; then
  echo "Error: Failed to copy docs content to temporary directory!"
  exit 1
fi

# Switch to gh-pages branch
echo "Switching to gh-pages branch..."
git checkout gh-pages

# Save current directory
CURRENT_DIR=$(pwd)
echo "Current directory: $CURRENT_DIR"

# Check if we're in the right place
if [[ "$CURRENT_DIR" != *corp-fin-mgt ]]; then
  echo "Error: Not in the expected directory!"
  exit 1
fi

# Remove all files (except .git)
echo "Removing existing files in gh-pages branch..."
find . -mindepth 1 -maxdepth 1 ! -name ".git" ! -name "." -exec rm -rf {} \;

# Copy the content from temp directory
echo "Copying website content from temporary directory..."
cp -r $TEMP_DIR/* .

# Verify the copy was successful
if [ -z "$(ls -A | grep -v '^\.git$')" ]; then
  echo "Error: Failed to copy content to gh-pages branch!"
  # Switch back to main branch
  git checkout main
  # Remove temp directory
  rm -rf $TEMP_DIR
  exit 1
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit and push
echo "Committing changes..."
git commit -m "Restore GitHub Pages content" || echo "No changes to commit"

echo "Pushing to GitHub..."
git push origin gh-pages

# Return to main branch
echo "Switching back to main branch..."
git checkout main

# Remove temp directory
echo "Cleaning up..."
rm -rf $TEMP_DIR

echo "Process completed. Check https://quinfer.github.io/corp-fin-mgt/" 