#!/bin/bash
# validate-structure.sh - Script for validating the project structure
# Usage: ./validate-structure.sh

set -e  # Exit on any error

# Change to the project root directory regardless of where the script is called from
cd "$(dirname "$0")/.."
PROJECT_ROOT=$(pwd)
echo "Running from project root: $PROJECT_ROOT"

echo "Validating project structure..."

# Check for required directories
required_dirs=("days" "slides" "_assets" "_scripts")
missing_dirs=false

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "ERROR: Required directory '$dir' is missing!"
    missing_dirs=true
  fi
done

# Create resources directory if it doesn't exist
if [ ! -d "resources" ]; then
  echo "WARNING: Required directory 'resources' is missing! Creating it..."
  mkdir -p resources
  
  # Create a basic index.qmd in the resources directory
  if [ ! -f "resources/index.qmd" ]; then
    echo "Creating basic resources/index.qmd..."
    cat > resources/index.qmd << EOF
---
title: "Course Resources"
---

# Course Resources

This page contains resources for the Corporate Financial Management course.

## Module Handbook

The module handbook can be downloaded [here](/resources/module-handbook.html).

## Additional Materials

Additional course materials will be added here throughout the course.
EOF
  fi
fi

# Check for required files
required_files=("index.qmd")
missing_files=false

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "ERROR: Required file '$file' is missing!"
    missing_files=true
  fi
done

# Check for _quarto.yml or _quarto.yaml
if [ ! -f "_quarto.yml" ] && [ ! -f "_quarto.yaml" ]; then
  echo "ERROR: Quarto configuration file (_quarto.yml or _quarto.yaml) is missing!"
  missing_files=true
else
  # If _quarto.yaml exists but _quarto.yml doesn't, create a symlink
  if [ -f "_quarto.yaml" ] && [ ! -f "_quarto.yml" ]; then
    echo "Creating symlink from _quarto.yaml to _quarto.yml..."
    ln -s _quarto.yaml _quarto.yml
  fi
fi

# Ensure styles.css exists in the right location
if [ ! -f "_assets/css/styles.css" ]; then
  echo "WARNING: _assets/css/styles.css missing. Looking in root directory..."
  if [ -f "styles.css" ]; then
    echo "Found styles.css in root. Copying to _assets/css/..."
    mkdir -p _assets/css
    cp styles.css _assets/css/styles.css
  else
    echo "WARNING: No styles.css found. Creating a basic one..."
    mkdir -p _assets/css
    cat > _assets/css/styles.css << EOF
/* Basic styles for Corporate Financial Management website */
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.6;
}

h1, h2, h3, h4, h5, h6 {
  color: #2c3e50;
  margin-top: 1.5em;
}

code {
  background-color: #f8f9fa;
  border-radius: 3px;
  padding: 2px 4px;
}

table {
  border-collapse: collapse;
  margin: 1em 0;
}

th, td {
  padding: 8px 12px;
  border: 1px solid #ddd;
}

th {
  background-color: #f2f2f2;
}

.callout {
  border-left: 5px solid #2c3e50;
  background-color: #f8f9fa;
  padding: 15px;
  margin: 20px 0;
}
EOF
  fi
fi

# Create placeholder favicon.ico if missing
if [ ! -f "_assets/images/favicon.ico" ]; then
  echo "WARNING: favicon.ico missing. Creating placeholder..."
  mkdir -p _assets/images
  touch _assets/images/favicon.ico
fi

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

# Create placeholder day4 files if they don't exist but are referenced
if grep -q "day4" _quarto.yml || grep -q "day4" index.qmd; then
  for day4_file in "day4.qmd" "day4-morning.qmd" "day4-afternoon.qmd"; do
    if [ ! -f "days/$day4_file" ]; then
      echo "WARNING: days/$day4_file is referenced but missing. Creating placeholder..."
      cat > "days/$day4_file" << EOF
---
title: "Corporate Financial Management"
subtitle: "$(echo "$day4_file" | sed 's/.qmd//' | sed 's/day4/Day 4/' | sed 's/-/ - /' | sed 's/morning/Morning Session/' | sed 's/afternoon/Afternoon Session/')"
author: "Prof. Barry Quinn"
institute: "Ulster University Business School"
---

# Coming Soon

This content will be available soon.
EOF
    fi
  done
fi

# Exit if any required directories or files are missing
if [ "$missing_dirs" = true ] || [ "$missing_files" = true ]; then
  echo "ERROR: Validation failed! Please fix the issues listed above."
  exit 1
fi

echo "Project structure validation successful!"
