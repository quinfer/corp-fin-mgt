#!/bin/bash
# manual-publish.sh - Interactive script for manual GitHub Pages publishing
# Usage: ./manual-publish.sh

# Function to pause and wait for user confirmation
confirm() {
  local prompt="$1"
  echo -e "\n=========================="
  echo -e "\033[1;33m$prompt\033[0m"
  echo -e "==========================\n"
  read -p "Press Enter to continue or Ctrl+C to abort..."
}

# Exit on any error
set -e

echo -e "\033[1;32m=== MANUAL GITHUB PAGES PUBLISHING ===\033[0m"
echo "This script will guide you through manually updating GitHub Pages."
echo "You will need to confirm each step."

# Step 1: Verify current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
confirm "You are currently on branch: $current_branch"

# Step 2: Check for remote repository
remote_url=$(git remote get-url origin)
confirm "Your remote repository URL is: $remote_url"

# Step 3: Verify docs directory exists
if [ -d "docs" ]; then
  doc_count=$(find docs -type f | wc -l)
  echo "The docs/ directory exists and contains $doc_count files."
else
  echo "ERROR: The docs/ directory does not exist!"
  exit 1
fi
confirm "Docs directory check complete."

# Step 4: Add .nojekyll file
touch docs/.nojekyll
echo "Created .nojekyll file in docs/ directory."
confirm "Continue to stash any current changes"

# Step 5: Stash any current changes
git stash save "Temporary stash before gh-pages update" || echo "No changes to stash"
confirm "Changes stashed. Will now check if gh-pages branch exists"

# Step 6: Check if gh-pages branch exists
if git show-ref --verify --quiet refs/heads/gh-pages; then
  echo "gh-pages branch exists locally."
else
  echo "gh-pages branch does not exist locally. Will create it."
fi
confirm "Will now create or checkout gh-pages branch"

# Step 7: Create or checkout gh-pages branch
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git checkout gh-pages
  echo "Checked out existing gh-pages branch."
else
  git checkout --orphan gh-pages
  git rm -rf .
  echo "Created new gh-pages branch and cleared content."
fi
confirm "Now on gh-pages branch. Will clear any existing content."

# Step 8: Clear existing content on gh-pages
find . -maxdepth 1 ! -path "./.git" ! -path "." -exec rm -rf {} \; 2>/dev/null || true
echo "Cleared existing content from gh-pages branch."
confirm "Will now copy content from docs/ directory"

# Step 9: Copy docs content
git checkout "$current_branch" -- docs/
echo "Checked out docs/ directory from $current_branch branch."
confirm "Will now move docs content to root of gh-pages branch"

# Step 10: Move content to root
cp -r docs/* .
cp -r docs/.* . 2>/dev/null || true
echo "Copied docs content to root of gh-pages branch."
confirm "Will now add all files to git"

# Step 11: Add files to git
git add -A
echo "Added all files to git."
confirm "Will now commit changes"

# Step 12: Commit changes
git commit -m "Manual update of GitHub Pages: $(date)" || echo "No changes to commit"
echo "Committed changes to gh-pages branch."
confirm "Will now push changes to remote repository"

# Step 13: Push changes
git push -f origin gh-pages
echo "Pushed changes to remote gh-pages branch."
confirm "Will now switch back to original branch"

# Step 14: Switch back to original branch
git checkout "$current_branch"
echo "Switched back to $current_branch branch."
confirm "Will now restore stashed changes"

# Step 15: Restore stashed changes
git stash pop || echo "No stashed changes to restore"
echo "Restored stashed changes (if any)."

echo -e "\033[1;32m=== MANUAL PUBLISHING COMPLETE ===\033[0m"
echo "GitHub Pages should now be updated with the contents of your docs/ directory."
echo "Visit https://quinfer.github.io/corp-fin-mgt/ to see your site."
echo "Note: It may take a few minutes for GitHub Pages to update."
