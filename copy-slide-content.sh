#!/bin/bash

# This script copies content from the days folder to recreate slide files

# First, backup existing slide files
mkdir -p slides-backup
cp slides/*.qmd slides-backup/

# Create temporary working directory
mkdir -p temp-slides

# Copy full content files for each day's slides
echo "Copying slide content from days folder..."

# Day 1 Morning
echo "Creating day1-morning-slides.qmd..."
cp days/day1-morning.qmd temp-slides/day1-morning-slides.qmd

# Day 1 Afternoon
echo "Creating day1-afternoon-slides.qmd..."
cp days/day1-afternoon.qmd temp-slides/day1-afternoon-slides.qmd

# Day 2 Morning
echo "Creating day2-morning-slides.qmd..."
cp days/day2-morning.qmd temp-slides/day2-morning-slides.qmd

# Day 2 Afternoon
echo "Creating day2-afternoon-slides.qmd..."
cp days/day2-afternoon.qmd temp-slides/day2-afternoon-slides.qmd

# Day 3 Morning
echo "Creating day3-morning-slides.qmd..."
cp days/day3-morning.qmd temp-slides/day3-morning-slides.qmd

# Day 3 Afternoon
echo "Creating day3-afternoon-slides.qmd..."
cp days/day3-afternoon.qmd temp-slides/day3-afternoon-slides.qmd

# Now replace the format settings in these files to make them RevealJS slides
for file in temp-slides/*.qmd; do
    # First, create a clean YAML header for RevealJS
    base_name=$(basename "$file" -slides.qmd)
    title=$(grep -m 1 'title:' "$file" | sed 's/title: *//' | sed 's/"//g')
    subtitle=$(grep -m 1 'subtitle:' "$file" | sed 's/subtitle: *//' | sed 's/"//g')
    author=$(grep -m 1 'author:' "$file" | sed 's/author: *//' | sed 's/"//g')
    
    # Extract content after YAML header
    content=$(sed -n '/^---/,/^---/d; p' "$file")
    
    # Create new file with proper RevealJS YAML header
    cat > "$file" << EOL
---
title: "$title"
subtitle: "$subtitle"
author: "$author"
date: last-modified
format:
  revealjs:
    theme: simple
    incremental: true
    slide-number: true
    footer: "Corporate Financial Management - ${base_name^^}"
    self-contained: true
    controls-layout: bottom-right
    controls-tutorial: true
    transition: slide
    print-pdf-size: letter
    print-pdf-margin: 1cm
---

$content
EOL
    
    # Copy to slides folder
    cp "$file" "slides/$(basename "$file")"
    echo "Created slides/$(basename "$file")"
done

# Clean up
rm -rf temp-slides

echo "Complete: All slide files have been updated with full content."
echo "You can now manually remove tabsets before publishing."
echo "Original slide files are backed up in slides-backup/ if needed." 