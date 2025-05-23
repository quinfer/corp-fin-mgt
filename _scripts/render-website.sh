#!/bin/bash
# render-website.sh - Main script for building the entire website
# Usage: ./render-website.sh [--clean]

set -e  # Exit on any error

# Change to the project root directory regardless of where the script is called from
cd "$(dirname "$0")/.."
PROJECT_ROOT=$(pwd)
echo "Running from project root: $PROJECT_ROOT"

# Process arguments
CLEAN=false
for arg in "$@"; do
  case $arg in
    --clean)
      CLEAN=true
      shift
      ;;
  esac
done

# Clean the docs directory if --clean is specified
if [ "$CLEAN" = true ]; then
  echo "Cleaning docs directory..."
  rm -rf docs/
  mkdir -p docs/
fi

# Create required directories if they don't exist
echo "Ensuring output directories exist..."
mkdir -p docs/
mkdir -p docs/days/
mkdir -p docs/slides/
mkdir -p docs/resources/
mkdir -p docs/_assets/

# Copy asset files
echo "Copying asset files..."
cp -r _assets/ docs/

# Run all the build scripts in the correct order
echo "Step 1: Validating project structure..."
./_scripts/validate-structure.sh

echo "Step 2: Rendering resources..."
# Check if resources directory exists and has content
if [ -d "resources" ] && [ "$(ls -A resources/)" ]; then
  quarto render resources/ --output-dir docs/resources/
else
  echo "  Resources directory empty or missing. Creating placeholder."
  mkdir -p resources
  [ ! -f "resources/index.qmd" ] && echo "---\ntitle: Resources\n---\n\n# Course Resources\n\nResources will be added here." > resources/index.qmd
  quarto render resources/ --output-dir docs/resources/
fi

echo "Step 3: Rendering slide presentations..."
./_scripts/render-slides.sh

echo "Step 4: Rendering day content..."
./_scripts/render-days.sh

echo "Step 5: Rendering main website pages..."
quarto render index.qmd

echo "Step 6: Validating the build..."
./_scripts/validate-site.sh

echo "Done! Website has been built successfully."
echo "View your site locally by running: quarto preview"
echo "Publish to GitHub Pages by running: ./_scripts/publish.sh"
