#!/bin/bash

# This script cleans up the slides directories by removing website artifacts
# and then properly re-renders all slides

echo "Cleaning up slides directories and re-rendering slides..."

# Step 1: First, run the existing render-slide-authors.sh script to render slides
echo "Running render-slide-authors.sh to generate slides..."
bash render-slide-authors.sh

# Step 2: Clean up any website artifacts in the docs/slides directory
echo "Removing website artifacts from docs/slides..."
rm -f docs/slides/sitemap.xml docs/slides/robots.txt docs/slides/search.json docs/slides/index.html
rm -rf docs/slides/site_libs

# Step 3: Clean up any website artifacts in the slides directory
echo "Removing website artifacts from slides directory..."
rm -f slides/sitemap.xml slides/robots.txt slides/search.json slides/index.html
rm -rf slides/site_libs

echo "Slides cleanup and rendering completed successfully!"
echo "All website artifacts have been removed from the slides directories."
echo "The slides have been placed in both docs/slides/ (for publishing) and slides/ (for local viewing)."
echo "You can now run the safe-publish.sh script to publish the updated site." 