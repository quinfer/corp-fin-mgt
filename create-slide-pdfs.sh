#!/bin/bash

# This script creates PDF versions of slide presentations
# It converts RevealJS slides to Beamer LaTeX presentations

# Create a slides-pdf directory if it doesn't exist
mkdir -p slides-pdf

# Function to convert RevealJS slide file to Beamer PDF
convert_to_beamer() {
    local slide_qmd="$1"
    local beamer_qmd="slides-pdf/$(basename "$slide_qmd" .qmd)-beamer.qmd"
    
    echo "Creating Beamer version of $slide_qmd..."
    
    # Create a Beamer QMD file with appropriate frontmatter
    cat > "$beamer_qmd" << EOL
---
title: "$(grep -m 1 'title:' "$slide_qmd" | sed 's/title: *//' | sed 's/"//g')"
subtitle: "$(grep -m 1 'subtitle:' "$slide_qmd" | sed 's/subtitle: *//' | sed 's/"//g')"
author: "$(grep -m 1 'author:' "$slide_qmd" | sed 's/author: *//' | sed 's/"//g')"
date: "$(date "+%B %d, %Y")"
format:
  beamer:
    theme: "Frankfurt"
    colortheme: "dolphin"
    fonttheme: "structurebold"
    incremental: false
    slide-level: 2
    toc: true
    aspectratio: 169
---

EOL

    # Extract slides from the original file
    # First get everything after the YAML header
    sed -n '/^---/,/^---/ d; p' "$slide_qmd" | 
    # Remove R code chunks
    sed '/^```{r/,/^```/ d' |
    # Convert level 2 headers to slides
    sed 's/^## /# /' |
    # Convert level 3 headers in panel-tabsets to level 2 headers for slides
    awk '
    BEGIN { in_panel = 0; }
    /:::{\.panel-tabset/ { 
        in_panel = 1; 
        next; 
    }
    /:::/ && in_panel { 
        in_panel = 0; 
        next; 
    }
    /^### / && in_panel {
        print "## " substr($0, 5);
        next;
    }
    {
        if (!in_panel || $0 !~ /^:::/) {
            print;
        }
    }' >> "$beamer_qmd"
    
    # Render the Beamer file to PDF
    echo "Rendering $beamer_qmd to PDF..."
    quarto render "$beamer_qmd" --to beamer
}

# Process all QMD files in the slides directory
for slide_qmd in slides/*.qmd; do
    if [ -f "$slide_qmd" ]; then
        convert_to_beamer "$slide_qmd"
    fi
done

# Check if PDFs were created
pdf_count=$(find slides-pdf -maxdepth 1 -name "*.pdf" | wc -l | tr -d ' ')
if [ "$pdf_count" -gt 0 ]; then
    echo "Successfully generated $pdf_count PDF files in the slides-pdf directory:"
    find slides-pdf -maxdepth 1 -name "*.pdf" | sort
else
    echo "No PDFs were generated. Try running the individual Beamer files manually:"
    echo "cd slides-pdf && quarto render *-beamer.qmd --to beamer"
fi 