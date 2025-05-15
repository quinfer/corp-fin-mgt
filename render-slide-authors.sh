#!/bin/bash

# This script re-renders all slide presentations to ensure author names are correct
# It follows the workflow of the original render-slides.sh script

echo "Re-rendering all slide presentations to update author names..."

# Create output directory
echo "Creating slides directory..."
mkdir -p docs/slides

# Day 1 Morning
echo "Rendering Day 1 morning slides..."
cp slides-src/day1-morning-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day1-morning-slides.html

# Day 1 Afternoon
echo "Rendering Day 1 afternoon slides..."
cp slides-src/day1-afternoon-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day1-afternoon-slides.html

# Day 2 Morning
echo "Rendering Day 2 morning slides..."
cp slides-src/day2-morning-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day2-morning-slides.html

# Day 2 Afternoon
echo "Rendering Day 2 afternoon slides..."
cp slides-src/day2-afternoon-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day2-afternoon-slides.html

# Day 3 Morning
echo "Rendering Day 3 morning slides..."
cp slides-src/day3-morning-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day3-morning-slides.html

# Day 3 Afternoon
echo "Rendering Day 3 afternoon slides..."
cp slides-src/day3-afternoon-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day3-afternoon-slides.html

# Clean up the temp file
rm -f temp-slides.qmd

# Also copy the rendered HTML files to the slides/ directory for local viewing
echo "Copying rendered slides to slides/ directory for local viewing..."
mkdir -p slides
cp -r docs/slides/* slides/

echo "All slides rendered successfully with updated author information."
echo "The slides have been placed in both docs/slides/ (for publishing) and slides/ (for local viewing)."
echo "You can now run the safe-publish.sh script to publish the updated site." 