# Corporate Financial Management Course Website

This repository contains the source files for the Corporate Financial Management course website and slide presentations.

## Project Structure

- `days/` - Contains the main course content QMD files for the website
- `slides/` - Contains QMD files specifically for RevealJS slide presentations
- `images/` - Contains images used in the content
- `styles.css` - CSS styles for the website
- `custom.css` - CSS styles for the presentations (if used)

## Building the Website and Presentations

Due to the way Quarto handles file rendering, we use a specialized script to build both the website content and the RevealJS presentations:

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

### Publishing

Once rendering is complete:

```bash
quarto publish
```

This will publish the entire website, including both the HTML pages and the RevealJS presentations.

## Creating New Slide Presentations

To create a new slide presentation:

1. Create a new QMD file in the `slides/` directory (e.g., `slides/day2-morning-slides.qmd`)
2. Configure it with the RevealJS format
3. Run the `render-website.sh` script to regenerate everything

## Viewing PDF Versions

You can create PDF versions of the slides directly from the RevealJS presentations:

1. Open any presentation in a browser (e.g., `docs/slides/day1-morning-slides.html`)
2. Press "P" to enter print mode
3. Use your browser's print function (Ctrl/Cmd+P)
4. Select "Save as PDF" as the destination
5. Configure as needed and click "Save"

## Troubleshooting

If you encounter any issues with the rendering process:

1. Make sure all the script files are executable (`chmod +x *.sh`)
2. Remove the entire docs directory first (`rm -rf docs`)
3. Run the scripts in order: `./render-website.sh`