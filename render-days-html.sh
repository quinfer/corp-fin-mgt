#!/bin/bash

# This script renders the QMD files in docs/days to HTML in place
# Run this after render-website.sh to complete the website

echo "Rendering QMD files to HTML in docs/days..."
cd docs/days

for file in *.qmd; do
  echo "  Rendering $file to HTML"
  filename=$(basename "$file" .qmd)
  quarto render "$file" --to html --output "$filename.html"
done

cd ../..

echo "All day files rendered to HTML successfully!"
echo "The website should now be ready to publish with 'quarto publish'" 