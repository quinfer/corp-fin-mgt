#!/bin/bash
# render-slides.sh - Script for rendering all RevealJS slide presentations
# Usage: ./render-slides.sh

set -e  # Exit on any error

echo "Creating slides output directory..."
mkdir -p docs/slides/

# Find all slide files in the slides directory
slide_files=$(find slides/ -name "*.qmd" -type f)

if [ -z "$slide_files" ]; then
  echo "No slide files found in slides/ directory."
  exit 0
fi

# Process each slide file
for slide_file in $slide_files; do
  # Extract the filename without directory or extension
  filename=$(basename "$slide_file" .qmd)
  echo "Rendering slide presentation: $filename"
  
  # Render the slide presentation with RevealJS format
  quarto render "$slide_file" --to revealjs --output-dir docs/slides/ --output "$filename.html"
  
  # Create a success indicator file to help with validation
  touch "docs/slides/$filename.rendered"
done

echo "All slide presentations rendered successfully."
