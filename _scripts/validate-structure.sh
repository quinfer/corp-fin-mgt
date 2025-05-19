#!/bin/bash
# validate-structure.sh - Script for validating the project structure
# Usage: ./validate-structure.sh

set -e  # Exit on any error

echo "Validating project structure..."

# Check for required directories
required_dirs=("days" "slides" "resources" "_assets" "_scripts")
missing_dirs=false

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "ERROR: Required directory '$dir' is missing!"
    missing_dirs=true
  fi
done

# Check for required files
required_files=("_quarto.yml" "index.qmd")
missing_files=false

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "ERROR: Required file '$file' is missing!"
    missing_files=true
  fi
done

# Check permissions on script files
script_files=(
  "_scripts/render-website.sh"
  "_scripts/render-slides.sh"
  "_scripts/render-days.sh"
  "_scripts/validate-site.sh"
  "_scripts/validate-structure.sh"
  "_scripts/publish.sh"
)

for script in "${script_files[@]}"; do
  if [ -f "$script" ]; then
    if [ ! -x "$script" ]; then
      echo "WARNING: Script '$script' is not executable. Setting executable permission..."
      chmod +x "$script"
    fi
  fi
done

# Exit if any required directories or files are missing
if [ "$missing_dirs" = true ] || [ "$missing_files" = true ]; then
  echo "ERROR: Validation failed! Please fix the issues listed above."
  exit 1
fi

echo "Project structure validation successful!"
