# Corporate Finance Management Website

This repository contains the source files for the Corporate Finance Management course website.

## Website Structure

- `days/`: Regular HTML content pages for daily sessions
- `slides/`: RevealJS presentation slides
- `resources/`: Additional course materials
- `_assets/`: Static assets (images, CSS, includes)
- `_scripts/`: Build and maintenance scripts
- `docs/`: Generated website files (don't edit directly)
- `_quarto.yml`: Main configuration file for the Quarto website

## Robust Workflow for Updating the Website

### 1. Make Your Changes
- Edit source files in `days/`, `slides/`, or `resources/` as needed.
- Place any images or assets in the `_assets/` directory.
- Do **not** edit files in `docs/` directly.
- **IMPORTANT**: Ensure all QMD files have an explicit format section (see format requirements below).

### 2. Render the Website
- Use the main render script to build the entire site:
  ```bash
  ./_scripts/render-website.sh
  ```
- For incremental builds without cleaning, omit the `--clean` flag:
  ```bash
  ./_scripts/render-website.sh
  ```
- For specific components only:
  ```bash
  # For slides only:
  ./_scripts/render-slides.sh
  
  # For days content only:
  ./_scripts/render-days.sh
  ```

### 3. Validate the Build
- Check for potential issues with the validation script:
  ```bash
  ./_scripts/validate-site.sh
  ```
- Fix any reported broken links or missing files.

### 4. Preview the Website Locally
- Use Quarto's preview functionality to view the site:
  ```bash
  quarto preview
  ```

### 5. Publish to GitHub Pages
- Use the publish script to update the GitHub Pages:
  ```bash
  ./_scripts/publish.sh
  ```
- This script will:
  - Validate the website structure
  - Push the contents of `docs/` to the `gh-pages` branch
  - Add a timestamp to force browser cache refresh
  - Return you to your working branch

### 6. Verify the Website
- Visit your GitHub Pages URL (e.g., https://quinfer.github.io/corp-fin-mgt/) to confirm your changes are live.
- It may take a few minutes for updates to appear.

## Format Requirements

### Required YAML Format for All Content Files

Each .qmd file must include an explicit format section in its YAML header:

#### For Day Content Files (in days/ directory):
```yaml
---
title: "Corporate Financial Management"
subtitle: "Day X: Topic"
author: "Barry Quinn"
date: last-modified
format:
  html:
    number-sections: true  # Required format section
---
```

#### For Slide Files (in slides/ directory):
```yaml
---
title: "Corporate Financial Management"
subtitle: "Day X: Topic"
author: "Barry Quinn"
date: last-modified
format:
  revealjs:
    theme: simple
    slide-number: true
    footer: "Corporate Financial Management"
    embed-resources: true
    smaller: true
    scrollable: true
---
```

#### For Resource Files (in resources/ directory):
```yaml
---
title: "Resource Title"
subtitle: "Corporate Financial Management"
format:
  html:
    toc: true
---
```

**IMPORTANT NOTE**: The explicit format section in each file is critical for proper rendering and preview functionality. Files without an explicit format section may cause "No such file or directory" errors during preview.

## Troubleshooting

### Common Issues and Solutions

- **"No such file or directory" errors during preview**:
  - Ensure all .qmd files have an explicit format section in their YAML header
  - Check that file paths in _quarto.yml and content files use .html extensions (not .qmd)
  - Use site-root-relative paths (with leading slash) for cross-directory links

- **Broken links in the published site**:
  - Check relative paths in your links
  - Ensure they use proper `../` notation or `/` for site-root relative links
  - Run `./_scripts/validate-site.sh` to identify broken links

- **Slides not rendering correctly**:
  - Verify RevealJS format settings in the slide YAML headers
  - Check that all assets are properly referenced

- **Changes not appearing on GitHub Pages**:
  - The `./_scripts/publish.sh` script adds a timestamp to force cache refresh
  - Wait a few minutes for GitHub Pages to update
  - Check the GitHub Actions tab to see if any deployment errors occurred

- **For persistent issues**, clean and rebuild:
  ```bash
  ./_scripts/render-website.sh --clean
  ```

## Path Reference Guide

- **In the same directory**: Use just the filename
  - Example: `[Link](filename.html)`
  
- **To a file in another directory**: Use site-root-relative paths (start with /)
  - Example: `[Link](/days/day1.html)`
  
- **Within _quarto.yml navigation**: Always use .html extensions
  - Example: `href: days/day1.html`

## Directory Structure Details

```
project/
│
├── _quarto.yml                # Main configuration
├── index.qmd                  # Landing page
├── README.md                  # This file
│
├── days/                      # Day content
│   ├── day1.qmd
│   ├── day1-morning.qmd
│   └── ...
│
├── slides/                    # Slides
│   ├── day1-morning-slides.qmd
│   └── ...
│
├── resources/                 # Resources
│   ├── index.qmd
│   └── ...
│
├── _scripts/                  # Build scripts
│   ├── render-website.sh
│   └── ...
│
├── _assets/                   # Static assets
│   ├── images/
│   ├── css/
│   └── includes/
│
└── docs/                      # Generated output
```

## Important Notes

1. Always keep your QMD source files in the appropriate directories
2. Use relative paths consistently for links and assets
3. Never manually edit files in the `docs/` directory or `gh-pages` branch
4. The `.nojekyll` file is important to ensure proper rendering on GitHub Pages
5. Every QMD file must have an explicit format section in its YAML header

## License

[Include license information here]