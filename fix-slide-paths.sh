#!/bin/bash

# This script creates a cleaner slide structure by:
# 1. Moving source QMD files from slides-src/ to slides/
# 2. Removing website artifacts from slides/
# 3. Re-rendering slides properly to docs/slides/

echo "Fixing slide directory structure..."

# Step 1: Create clean directories for our restructuring
echo "Setting up clean directories..."
mkdir -p temp_slides
mkdir -p docs/slides

# Step 2: Move all source QMD files to the temp directory
echo "Gathering slide source files..."
cp -r slides-src/*.qmd temp_slides/

# Step 3: Clean the slides directory of website artifacts
echo "Cleaning up slides directory..."
rm -rf slides/sitemap.xml slides/search.json slides/robots.txt slides/site_libs slides/index.html slides/.nojekyll

# Step 4: Render each slide properly 
echo "Rendering slides..."
for slide in temp_slides/*.qmd; do
  if [ -f "$slide" ]; then
    basename=$(basename "$slide")
    output_name="${basename%.qmd}.html"
    
    echo "Rendering $basename..."
    
    # First copy the source QMD to the slides folder (for source preservation)
    cp "$slide" "slides/$basename"
    
    # Then render it to docs/slides for the website
    cp "$slide" temp-slide.qmd
    quarto render temp-slide.qmd --to revealjs --output-dir docs/slides --output "$output_name"
    
    # And copy the rendered HTML to slides/ for local viewing
    cp "docs/slides/$output_name" "slides/$output_name"
  fi
done

# Step 5: Clean up temporary files
echo "Cleaning up..."
rm -rf temp_slides
rm -f temp-slide.qmd

# Step 6: Remove slides-src directory as it's no longer needed
echo "Removing redundant slides-src directory..."
rm -rf slides-src

# Step 7: Remove any existing slides-src in docs if it still exists
echo "Cleaning up docs directory..."
if [ -d "docs/slides-src" ]; then
  rm -rf docs/slides-src
fi

# Step 8: Re-render the website to ensure links work properly
echo "Re-rendering the main website..."
quarto render index.qmd
quarto render resources.qmd
quarto render days/presentations.qmd

echo "Slide directory structure fixed!"
echo "slides/ now contains both source QMD files and rendered HTML files without website artifacts"
echo "docs/slides/ contains properly rendered slide HTML files for the website"
echo "All links should now correctly point to ../slides/day*-slides.html" 