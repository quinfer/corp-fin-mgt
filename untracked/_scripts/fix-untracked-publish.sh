#!/bin/bash
# fix-untracked-publish.sh - GitHub Pages publishing script that handles untracked files
# Usage: ./fix-untracked-publish.sh

# Exit on any error
set -e

echo -e "\033[1;32m=== GITHUB PAGES PUBLISHING (HANDLES UNTRACKED FILES) ===\033[0m"

# Step 1: Verify current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "You are currently on branch: $current_branch"

# Step 2: Check for docs directory
if [ ! -d "docs" ]; then
  echo "ERROR: The docs/ directory does not exist!"
  exit 1
fi

# Step 3: Create a temporary directory
temp_dir=$(mktemp -d)
echo "Created temporary directory: $temp_dir"

# Step 4: Copy docs content to temp directory
echo "Copying docs/ content to temporary directory..."
cp -r docs/* $temp_dir/
touch $temp_dir/.nojekyll

# Step 5: Handle untracked files
echo "Checking for untracked files..."
untracked_files=$(git ls-files --others --exclude-standard)
if [ -n "$untracked_files" ]; then
  echo "Found untracked files. Moving them to temporary directory..."
  mkdir -p $temp_dir/untracked
  for file in $untracked_files; do
    mkdir -p $temp_dir/untracked/$(dirname "$file")
    cp -r "$file" $temp_dir/untracked/$(dirname "$file")/
  done
fi

# Step 6: Stash tracked changes
git stash save "Temporary stash before gh-pages update" || echo "No tracked changes to stash"

# Step 7: Remove untracked files
if [ -n "$untracked_files" ]; then
  echo "Removing untracked files from working directory..."
  for file in $untracked_files; do
    rm -rf "$file"
  done
fi

# Step 8: Switch to gh-pages branch
echo "Switching to gh-pages branch..."
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git checkout gh-pages
else
  git checkout --orphan gh-pages
  git rm -rf .
fi

# Step 9: Clear existing content on gh-pages
echo "Clearing existing content from gh-pages branch..."
find . -maxdepth 1 ! -path "./.git" ! -path "." -exec rm -rf {} \; 2>/dev/null || true

# Step 10: Copy content from temp directory
echo "Copying content from temporary directory to gh-pages branch..."
cp -r $temp_dir/* .
cp -r $temp_dir/.[!.]* . 2>/dev/null || true

# Step 11: Add and commit changes
echo "Adding and committing changes..."
git add -A
git commit -m "Update GitHub Pages: $(date)" || echo "No changes to commit"

# Step 12: Push changes
echo "Pushing changes to remote gh-pages branch..."
git push -f origin gh-pages

# Step 13: Switch back to original branch
echo "Switching back to original branch..."
git checkout "$current_branch"

# Step 14: Restore untracked files
if [ -n "$untracked_files" ]; then
  echo "Restoring untracked files..."
  for file in $untracked_files; do
    mkdir -p $(dirname "$file")
    cp -r $temp_dir/untracked/$file $file
  done
fi

# Step 15: Restore stashed changes
git stash pop 2>/dev/null || echo "No stashed changes to restore"

# Step 16: Clean up
echo "Cleaning up temporary directory..."
rm -rf $temp_dir

echo -e "\033[1;32m=== PUBLISHING COMPLETE ===\033[0m"
echo "GitHub Pages should now be updated with the contents of your docs/ directory."
echo "Visit https://quinfer.github.io/corp-fin-mgt/ to see your site."
echo "Note: It may take a few minutes for GitHub Pages to update."
