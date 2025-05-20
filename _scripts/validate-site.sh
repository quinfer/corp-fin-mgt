#!/bin/bash
# validate-site.sh - Script for validating the website build
# Usage: ./validate-site.sh [--strict]

set -e  # Exit on any error

# Change to the project root directory regardless of where the script is called from
cd "$(dirname "$0")/.."
PROJECT_ROOT=$(pwd)
echo "Running from project root: $PROJECT_ROOT"

# Process arguments
STRICT=false
for arg in "$@"; do
  case $arg in
    --strict)
      STRICT=true
      shift
      ;;
  esac
done

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
expected_broken_links=0  # Counter for expected broken links
total_broken_links=0     # Counter for total broken links

# List of common patterns for expected broken links during transition
expected_patterns=(
  "favicon.ico"
  "site_libs/"
  "day4.qmd"
  "day4-morning.qmd" 
  "day4-afternoon.qmd"
  "_assets/images/"
  "styles.css"
  "figure-revealjs/"
  "figure-html/"
)

# Function to check if a link is broken
check_link() {
  local html_file="$1"
  local link="$2"
  
  # Skip data URIs, anchor links, javascript links, and external links
  if [[ "$link" == "data:"* || "$link" == "#"* || "$link" == "javascript:"* || "$link" == "mailto:"* || "$link" == "http"* ]]; then
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
    # Check if this is an expected broken link during transition
    is_expected=false
    for pattern in "${expected_patterns[@]}"; do
      if [[ "$link" == *"$pattern"* ]]; then
        is_expected=true
        ((expected_broken_links++))
        break
      fi
    done
    
    # Only show details for unexpected broken links or if strict mode
    if ! $is_expected || $STRICT; then
      echo "  Broken link in $html_file: $link"
      broken_links=true
    fi
    
    ((total_broken_links++))
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

# Report summary of broken links
echo "-----------------------------"
echo "Link check summary:"
echo "  Total broken links: $total_broken_links"
echo "  Expected broken links during transition: $expected_broken_links"
echo "  Unexpected broken links: $((total_broken_links - expected_broken_links))"
echo "-----------------------------"

# Final validation result
if [ "$broken_links" = true ] && [ "$STRICT" = true ]; then
  echo "ERROR: Validation failed in strict mode! Please fix the issues listed above."
  exit 1
elif [ "$broken_links" = true ]; then
  echo "WARNING: Some unexpected broken links were found. The site may still function but could have issues."
  echo "Run with --strict flag to fail on these errors."
  echo "Validation completed with warnings."
else
  echo "Validation successful! All checks passed."
fi
