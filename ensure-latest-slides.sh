#!/bin/bash

# This script ensures the latest slide renderings are in the docs directory before publishing

echo "Ensuring latest slide renderings are in docs directory..."

# Step 1: Verify slides directory exists
if [ ! -d "slides" ]; then
  echo "Error: slides directory doesn't exist!"
  exit 1
fi

# Step 2: Make sure docs/slides directory exists
mkdir -p docs/slides

# Step 3: Force re-render all slides from the source files to both directories
echo "Rendering slides from source files..."
for slide in slides/*.qmd; do
  if [ -f "$slide" ]; then
    basename=$(basename "$slide")
    output_name="${basename%.qmd}.html"
    
    echo "Rendering $basename to docs/slides/$output_name..."
    
    # Render to docs/slides directory
    quarto render "$slide" --to revealjs --output-dir docs/slides --output "$output_name"
    
    # Also update the HTML in the slides directory
    cp "docs/slides/$output_name" "slides/$output_name"
  fi
done

echo "All slides have been re-rendered to docs/slides/"
echo "Now you can run the safe-publish.sh script to publish the site" 