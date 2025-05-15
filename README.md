# Corporate Financial Management Course Website

This repository contains the source files for the Corporate Financial Management course website and slide presentations.

## Project Structure

- `days/` - Contains the main course content QMD files for the website
- `slides/` - Contains QMD files specifically for RevealJS slide presentations
- `images/` - Contains images used in the content
- `docs/` - Output directory containing the rendered website and slides
- `styles.css` - CSS styles for the website
- `custom.css` - CSS styles for the presentations (if used)

## Building the Website and Presentations

Due to the way Quarto handles file rendering, we use specialized scripts to build both the website content and the RevealJS presentations:

### Complete Build

To render both the website and slides in one step:

```bash
./render-website.sh
```

This script will:
1. Create the necessary directories
2. Render the main index and resources pages
3. Copy the days QMD files to the docs directory
4. Render all the slide presentations to RevealJS
5. Render all the day files to HTML
6. Put everything in the proper structure for publishing

## Publishing to GitHub Pages

We've discovered that Quarto's built-in publishing mechanism can encounter "Error moving file" issues with our project structure. To work around this, we've created custom publishing scripts:

### Simple Publishing (Recommended)

The simplest and most reliable way to publish the website is:

```bash
./simple-publish.sh
```

This script:
1. Ensures you're on the main branch
2. Commits and pushes any changes to main
3. Creates a temporary directory and copies the rendered docs/ content there
4. Switches to the gh-pages branch
5. Replaces all content with the docs/ content from the temporary directory
6. Commits and pushes to GitHub
7. Returns to the main branch

### Alternative Manual Publishing

For a more verbose publishing process with additional feedback:

```bash
./publish-manual.sh
```

This script provides more detailed output about each step in the publishing process.

## Creating New Content

### Adding New Website Pages

1. Create a new QMD file in the `days/` directory (e.g., `days/day4.qmd`)
2. Run the `render-website.sh` script to regenerate everything
3. Publish using `simple-publish.sh`

### Adding New Slide Presentations

1. Create a new QMD file in the `slides/` directory (e.g., `slides/day4-slides.qmd`)
2. Configure it with the RevealJS format
3. Run the `render-website.sh` script to regenerate everything
4. Publish using `simple-publish.sh`

## Viewing PDF Versions

There are two ways to access PDF versions of the slides:

### Option 1: Using the custom PDF generator script

For a more reliable approach that handles panel-tabsets properly:

```bash
./create-slide-pdfs.sh
```

This script:
1. Creates PDF-friendly versions of all your slide presentations
2. Converts panel-tabsets to regular content
3. Uses Quarto's native PDF rendering 
4. Outputs all PDFs to the slides-pdf/ directory

### Option 2: Direct from RevealJS 

You can create PDF versions of the slides directly from the RevealJS presentations:

1. Open any presentation in a browser (e.g., `docs/slides/day1-morning-slides.html`)
2. Press "P" to enter print mode
3. Use your browser's print function (Ctrl/Cmd+P)
4. Select "Save as PDF" as the destination
5. Configure as needed and click "Save"

Note: This method may not correctly handle panel tabsets and certain advanced features.

## Troubleshooting

If you encounter any issues with the rendering process:

1. Make sure all the script files are executable (`chmod +x *.sh`)
2. Remove the entire docs directory first (`rm -rf docs`)
3. Run the scripts in order: `./render-website.sh`
4. For publishing issues, always use `simple-publish.sh` instead of Quarto's built-in publishing

## Accessing the Website

After publishing, the website will be available at:
https://quinfer.github.io/corp-fin-mgt/