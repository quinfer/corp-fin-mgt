#!/bin/bash

# This script focuses only on rendering the RevealJS slides
# to avoid conflicts with the main website rendering

echo "Creating slides directory..."
mkdir -p docs/slides

# Day 1 Morning
echo "Rendering Day 1 morning slides..."
cp slides/day1-morning-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day1-morning-slides.html

# Day 1 Afternoon
echo "Rendering Day 1 afternoon slides..."
cp slides/day1-afternoon-slides.qmd temp-slides.qmd
quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day1-afternoon-slides.html

# Day 2 Morning
echo "Rendering Day 2 morning slides..."
if [ -f slides/day2-morning-slides.qmd ]; then
  cp slides/day2-morning-slides.qmd temp-slides.qmd
  quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day2-morning-slides.html
else
  echo "  Skipping - slides/day2-morning-slides.qmd doesn't exist yet"
fi

# Day 2 Afternoon
echo "Rendering Day 2 afternoon slides..."
if [ -f slides/day2-afternoon-slides.qmd ]; then
  cp slides/day2-afternoon-slides.qmd temp-slides.qmd
  quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day2-afternoon-slides.html
else
  echo "  Skipping - slides/day2-afternoon-slides.qmd doesn't exist yet"
fi

# Day 3 Morning
echo "Rendering Day 3 morning slides..."
if [ -f slides/day3-morning-slides.qmd ]; then
  cp slides/day3-morning-slides.qmd temp-slides.qmd
  quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day3-morning-slides.html
else
  echo "  Skipping - slides/day3-morning-slides.qmd doesn't exist yet"
fi

# Day 3 Afternoon
echo "Rendering Day 3 afternoon slides..."
if [ -f slides/day3-afternoon-slides.qmd ]; then
  cp slides/day3-afternoon-slides.qmd temp-slides.qmd
  quarto render temp-slides.qmd --to revealjs --output-dir docs/slides --output day3-afternoon-slides.html
else
  echo "  Skipping - slides/day3-afternoon-slides.qmd doesn't exist yet"
fi

# Clean up the temp file
rm -f temp-slides.qmd

echo "All slides rendered successfully to docs/slides/"
echo "Run 'quarto publish' to publish your site" 