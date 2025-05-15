# Corporate Financial Management Site Workflow

This document outlines the successful workflow for rendering and publishing the Corporate Financial Management course website, including both HTML content and RevealJS presentations.

## Directory Structure

- `days/`: Main content QMD files
- `slides/`: RevealJS presentation QMD files
- `docs/`: Output directory with HTML and slides subdirectories

## Rendering Process

The site uses three main rendering scripts:

1. `render-website.sh`: The main script that renders the entire website
   ```bash
   ./render-website.sh
   ```

2. `render-slides.sh`: Script to render RevealJS presentations
   ```bash
   ./render-slides.sh
   ```

3. `render-days-html.sh`: Script to render HTML files in the days/ directory
   ```bash
   ./render-days-html.sh
   ```

## Publishing Process

After facing persistent "Error moving file" issues with Quarto's publishing mechanism, we successfully implemented a git-based approach using the `fix-gh-pages.sh` script.

### Publishing Steps

1. Render the website using the rendering scripts
2. Use the `fix-gh-pages.sh` script to publish to GitHub Pages:
   ```bash
   ./fix-gh-pages.sh
   ```

This script:
- Creates a temporary directory
- Copies the docs/ directory content to the temp directory
- Switches to the gh-pages branch
- Removes all files (except .git)
- Copies the content from the temp directory
- Commits and pushes to GitHub
- Returns to the main branch

The advantage of this approach is that it completely bypasses Quarto's publishing mechanism, which was causing the errors.

## Troubleshooting

If the gh-pages branch becomes corrupted or empty:
1. Run the `fix-gh-pages.sh` script to restore proper content
2. Ensure all QMD files are properly rendered before publishing

## PDF Generation

For PDF versions of slide presentations:
1. Use the `create-slide-pdfs.sh` script (note: this may require fixing panel-tabsets)
2. Alternatively, open the HTML presentations in Chrome and print to PDF

## Important Notes

1. Always keep your QMD source files in the `days/` and `slides/` directories
2. The rendered HTML files will be placed in the `docs/` directory
3. Never manually edit files in the gh-pages branch
4. The .nojekyll file is important to ensure proper rendering on GitHub Pages 