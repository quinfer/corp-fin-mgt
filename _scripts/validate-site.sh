#!/bin/bash
# validate-site.sh - Script for validating the website build
# Usage: ./validate-site.sh

set -e  # Exit on any error

echo "Validating website build..."

# Check for expected directories
echo "Checking for required directories..."
required_dirs=("docs" "docs/days" "docs/slides" "docs/resources" "docs/_assets")
for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "ERROR: Required directory '$dir' is missing!"
    exit 1
  fi
done

# Check that index.html exists in the root
if [ ! -f "docs/index.html" ]; then
  echo "ERROR: Main index.html is missing!"
  exit 1
fi

# Check for broken relative links in HTML files
echo "Checking for broken links..."
broken_links=false

# Function to check if a link is broken
check_link() {
  local html_file="$1"
  local link="$2"
  
  # Skip external links, anchor links, and javascript links
  if [[ "$link" == "http"* || "$link" == "#"* || "$link" == "javascript:"* || "$link" == "mailto:"* ]]; then
    return 0
  fi
  
  # Get the directory of the HTML file
  local dir=$(dirname "$html_file")
  
  # Handle relative and absolute links
  if [[ "$link" == "/"* ]]; then
    # Absolute link (from site root)
    link="docs$link"
  else
    # Relative link (from current directory)
    link="$dir/$link"
  fi
  
  # Normalize the path (resolve ../, ./, etc.)
  link=$(realpath --relative-to=. "$link" 2>/dev/null || echo "$link")
  
  # Check if the link points to a file or directory
  if [ ! -e "$link" ]; then
    echo "  Broken link in $html_file: $link"
    broken_links=true
  fi
}

# Find all HTML files and extract links
find docs/ -name "*.html" -type f | while read html_file; do
  # Extract href attributes
  grep -o 'href="[^"]*"' "$html_file" | cut -d '"' -f 2 | while read link; do
    check_link "$html_file" "$link"
  done
  
  # Extract src attributes
  grep -o 'src="[^"]*"' "$html_file" | cut -d '"' -f 2 | while read link; do
    check_link "$html_file" "$link"
  done
done

# Check that all day content files were rendered
echo "Checking that all days content was rendered..."
for qmd_file in days/*.qmd; do
  base_name=$(basename "$qmd_file" .qmd)
  html_file="docs/days/$base_name.html"
  
  if [ ! -f "$html_file" ]; then
    echo "ERROR: Day content file $qmd_file was not rendered to $html_file"
    broken_links=true
  fi
done

# Check that all slide files were rendered
echo "Checking that all slides were rendered..."
for qmd_file in slides/*.qmd; do
  base_name=$(basename "$qmd_file" .qmd)
  html_file="docs/slides/$base_name.html"
  
  if [ ! -f "$html_file" ]; then
    echo "ERROR: Slide file $qmd_file was not rendered to $html_file"
    broken_links=true
  fi
done

# Final validation result
if [ "$broken_links" = true ]; then
  echo "ERROR: Validation failed! Please fix the issues listed above."
  exit 1
else
  echo "Validation successful! All checks passed."
fi
