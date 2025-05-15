#!/bin/bash

# This script fixes the footer field in all slide QMD files

for file in slides/*-slides.qmd; do
    # Get the base name for creating proper footer
    base_name=$(basename "$file" -slides.qmd)
    day_num=${base_name:3:1}  # Extract the day number (e.g., "1" from "day1")
    period=${base_name:5}     # Extract morning/afternoon
    
    # Capitalize first letter of period
    period_cap="$(tr '[:lower:]' '[:upper:]' <<< ${period:0:1})${period:1}"
    
    # Create the proper footer
    proper_footer="Corporate Financial Management - Day $day_num $period_cap"
    
    # Fix the footer using the literal string from the file
    sed -i '' 's/footer: "Corporate Financial Management - \$(basename "\$file" -slides.qmd | tr "\\[:lower:\\]" "\\[:upper:\\]")"/footer: "'"$proper_footer"'"/' "$file"
    
    echo "Fixed footer in $file"
done

echo "All footers fixed!" 