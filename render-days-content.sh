#!/bin/bash

# This script renders the content in the days folder as regular HTML files
# instead of RevealJS presentations by temporarily modifying the YAML headers

echo "Rendering days content as HTML files..."

# Create a backup directory
mkdir -p temp_backups

# List of files to render
DAY_FILES=(
  "days/day1-morning.qmd"
  "days/day1-afternoon.qmd"
  "days/day2-morning.qmd"
  "days/day2-afternoon.qmd"
  "days/day3-morning.qmd"
  "days/day3-afternoon.qmd"
  "days/day1.qmd"
  "days/day2.qmd"
  "days/day3.qmd"
  "days/presentations.qmd"
)

# Process each file
for file in "${DAY_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "Processing $file..."
    
    # Create a backup
    cp "$file" "temp_backups/$(basename "$file")"
    
    # Create a temporary file with modified YAML header
    awk '{
      if (count == 0 && $0 == "---") {
        print "---";
        count = 1;
      } else if (count == 1 && $0 == "---") {
        print "format:";
        print "  html:";
        print "    theme: cosmo";
        print "    toc: true";
        print "    css: \"../styles.css\"";
        print "---";
        count = 2;
      } else if (count == 1 && $0 ~ /^format:/) {
        # Skip existing format section until we find the closing of the section
        in_format = 1;
      } else if (in_format && $0 ~ /^[a-zA-Z]/) {
        # This line starts with a letter, meaning we are out of the format section
        in_format = 0;
        print $0;
      } else if (count == 1 && !in_format) {
        print $0;
      } else if (count == 2) {
        print $0;
      }
    }' "$file" > temp_file.qmd
    
    # Replace original with modified version
    mv temp_file.qmd "$file"
    
    # Render the file
    echo "Rendering modified $file as HTML..."
    quarto render "$file" --to html
    
    # Restore original from backup
    cp "temp_backups/$(basename "$file")" "$file"
    
    echo "Restored original $file"
  else
    echo "Warning: File $file not found, skipping."
  fi
done

# Clean up
rm -rf temp_backups
rm -f temp_file.qmd 2>/dev/null

echo "Done rendering days content as HTML files."
echo "Website content should now be correctly rendered in the docs/days/ directory." 