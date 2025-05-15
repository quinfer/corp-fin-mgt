# Corporate Finance Management Website

This repository contains the source files for the Corporate Finance Management course website.

## Website Structure

- `days/`: Regular HTML content pages (using `format: html` in YAML headers)
- `slides/`: RevealJS presentation slides (using `format: revealjs` in YAML headers)
- `docs/`: Generated website files (don't edit directly)
- `_quarto.yaml`: Main configuration file for the Quarto website

## Update Process Guide

### Maintaining Proper Rendering

To ensure content renders correctly:

1. **Content Structure Rules**
   - Always use `format: html` in YAML headers for `days/*.qmd` files
   - Always use `format: revealjs` in YAML headers for `slides/*.qmd` files
   - Never mix formats within the same directory

2. **Slide Formatting Update Process**
   - Edit slide content only in the `slides/*.qmd` files
   - Do not modify `days/*.qmd` files when you only want to update slides
   - After making changes, render with `quarto render` and test locally before publishing

3. **Content Update Process**
   - Edit regular content in the `days/*.qmd` files
   - Keep YAML headers consistent across similar files
   - Use a consistent CSS theme across content of the same type

### Rendering Scripts

The site has three specialized rendering scripts:

1. **`render-website.sh`**: The main script that renders the entire website
   ```bash
   ./render-website.sh
   ```

2. **`render-slides.sh`**: Script to render only the RevealJS presentations
   ```bash
   ./render-slides.sh
   ```

3. **`render-days-html.sh`**: Script to render only the HTML files in the days/ directory
   ```bash
   ./render-days-html.sh
   ```

### Publishing Workflow

1. **Rendering**
   ```bash
   ./render-website.sh
   # or use quarto directly
   quarto render
   ```

2. **Local Testing**
   ```bash
   cd docs && python3 -m http.server 8000
   ```
   Then visit http://localhost:8000 in your browser

3. **Committing Changes**
   ```bash
   git add .
   git commit -m "Descriptive message about your changes"
   ```

4. **Publishing**
   ```bash
   ./safe-publish.sh
   ```
   This script safely handles the publishing process to GitHub Pages, bypassing Quarto's native publishing mechanism.

### PDF Generation

For PDF versions of slide presentations:
1. Use the `create-slide-pdfs.sh` script (note: this may require fixing panel-tabsets)
2. Alternatively, open the HTML presentations in Chrome and print to PDF

### Common Update Scenarios

#### For slide formatting changes:
```bash
# 1. Edit the slide content in slides/*.qmd files
# 2. Render and test
./render-slides.sh
# 3. Commit changes
git add .
git commit -m "Update slide formatting in [specific slides]"
# 4. Publish
./safe-publish.sh
```

#### For content updates across the site:
```bash
# 1. Edit content in appropriate files
# 2. Render and test
./render-website.sh
# 3. Check both HTML and slide formats
# 4. Commit and publish
git add .
git commit -m "Update content in [specific files]"
./safe-publish.sh
```

## Troubleshooting

If content is not rendering correctly:

1. Check YAML headers in the affected files to ensure proper format settings
2. Verify that the _quarto.yaml file has the correct render settings
3. If necessary, remove the `_freeze/` directory and `docs/` directory before rendering again:
   ```bash
   rm -rf _freeze docs
   quarto render
   ```

If the gh-pages branch becomes corrupted or empty:
1. Run the `./safe-publish.sh` script to restore proper content
2. Ensure all QMD files are properly rendered before publishing

## Important Notes

1. Always keep your QMD source files in the `days/` and `slides/` directories
2. The rendered HTML files will be placed in the `docs/` directory
3. Never manually edit files in the gh-pages branch
4. The .nojekyll file is important to ensure proper rendering on GitHub Pages

## License

[Include license information here] 