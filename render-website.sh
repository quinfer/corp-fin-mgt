#!/bin/bash

# This script manually renders the website QMD files to avoid the file moving issues

echo "Creating output directories..."
mkdir -p docs/days

# Render index page and resource page
echo "Rendering main pages..."
quarto render index.qmd
quarto render resources.qmd

# Copy static files if needed
echo "Copying original QMD files to output directory..."
cp -r days/*.qmd docs/days/

# Now render the slides
echo "Now running slide rendering script..."
./render-slides.sh

# Now render the QMD files to HTML in place
echo "Now rendering days files to HTML..."
./render-days-html.sh

echo "All files rendered successfully!"
echo "Run 'quarto publish' to publish your site" 