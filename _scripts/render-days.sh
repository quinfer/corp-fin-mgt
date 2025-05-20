#!/bin/bash
# render-days.sh - Script for rendering all day content files
# Usage: ./render-days.sh

set -e  # Exit on any error

# Change to the project root directory regardless of where the script is called from
cd "$(dirname "$0")/.."
PROJECT_ROOT=$(pwd)
echo "Running from project root: $PROJECT_ROOT"

echo "Creating days output directory..."
mkdir -p docs/days/

# Find all day content files in the days directory
day_files=$(find days/ -name "*.qmd" -type f)

if [ -z "$day_files" ]; then
  echo "No day content files found in days/ directory."
  exit 0
fi

# Process each day file
for day_file in $day_files; do
  # Extract the filename without directory or extension
  filename=$(basename "$day_file" .qmd)
  echo "Rendering day content: $filename"
  
  # Render the day content to HTML
  quarto render "$day_file" --to html --output-dir docs/days/ --output "$filename.html"
  
  # Create a success indicator file to help with validation
  touch "docs/days/$filename.rendered"
done

echo "All day content files rendered successfully."
