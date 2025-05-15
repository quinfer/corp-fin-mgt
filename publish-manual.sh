#!/bin/bash

# This script manually publishes the website to GitHub Pages by
# copying the docs directory to the gh-pages branch

# Make sure we're on the main branch
echo "Switching to main branch..."
git checkout main

# Render the website
echo "Rendering the website..."
./render-website.sh

# Remember the absolute path to docs
DOCS_PATH=$(realpath docs)

# Commit any changes on main
echo "Committing changes on main branch..."
git add .
git commit -m "Update website content"

# Switch to gh-pages branch
echo "Switching to gh-pages branch..."
git checkout gh-pages

# Clean the branch (except for .git directory)
echo "Cleaning gh-pages branch..."
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} \;

# Copy the docs directory contents to root
echo "Copying docs directory to gh-pages branch..."
cp -r $DOCS_PATH/* .

# Add all files
echo "Adding files to gh-pages branch..."
git add .

# Commit the changes
echo "Committing changes to gh-pages branch..."
git commit -m "Update GitHub Pages website"

# Push to GitHub
echo "Pushing to GitHub..."
git push origin gh-pages

# Switch back to main branch
echo "Switching back to main branch..."
git checkout main

echo "Website successfully published to GitHub Pages!"
echo "Visit your site at https://quinfer.github.io/corp-fin-mgt/" 