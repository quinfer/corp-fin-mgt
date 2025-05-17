# Corporate Finance Management Website

This repository contains the source files for the Corporate Finance Management course website.

## Website Structure

- `days/`: Regular HTML content pages (using `format: html` in YAML headers)
- `slides/`: RevealJS presentation slides (using `format: revealjs` in YAML headers)
- `docs/`: Generated website files (don't edit directly)
- `_quarto.yaml`: Main configuration file for the Quarto website
- `_freeze/`: Quarto build cache (ignored by git, not tracked)

## Robust Workflow for Updating the Website

### 1. Make Your Changes
- Edit source files in `days/` or `slides/` as needed.
- Do **not** edit files in `docs/` or the `gh-pages` branch directly.

### 2. Render the Website
- Use the main render script to build the site:
  ```bash
  ./render-website.sh
  # or, for slides only:
  ./render-slides.sh
  # or, for days only:
  ./render-days-html.sh
  ```
- This will update the `docs/` directory with the latest output.

### 3. Check for Unstaged Changes
- Check for any changes that need to be committed:
  ```bash
  git status
  ```
- Stage and commit all relevant changes (especially in `docs/`):
  ```bash
  git add .
  git commit -m "Describe your update"
  ```

### 4. Push to GitHub
- Push your changes to the remote repository:
  ```bash
  git push
  ```

### 5. Publish to GitHub Pages
- Use the safe publish script to update the `gh-pages` branch:
  ```bash
  ./safe-publish.sh
  ```
- This script will:
  - Copy the contents of `docs/` to the `gh-pages` branch
  - Push the changes to GitHub
  - Switch you back to your working branch

### 6. Verify the Website
- Visit your GitHub Pages URL (e.g., https://quinfer.github.io/corp-fin-mgt/) to confirm your changes are live.
- It may take a few minutes for updates to appear.

### 7. Resolve Any Merge Conflicts
- If you see merge conflicts after publishing, resolve them as follows:
  1. Open each conflicted file and resolve the conflict.
  2. Stage the resolved files:
     ```bash
     git add <file>
     ```
  3. Commit the resolution:
     ```bash
     git commit -m "Resolve merge conflicts after publishing"
     ```
  4. Push to GitHub:
     ```bash
     git push
     ```

### 8. Ignore Build Cache
- The `_freeze/` directory is used by Quarto for build caching and should **not** be tracked by git.
- It is already included in `.gitignore`.
- If you ever see `_freeze/` files in `git status`, run:
  ```bash
  git rm -r --cached _freeze/
  git add .gitignore
  git commit -m "Ignore Quarto _freeze directory"
  git push
  ```

## Troubleshooting
- If content is not rendering correctly, check YAML headers and `_quarto.yaml`.
- If the `gh-pages` branch becomes corrupted or empty, re-run `./safe-publish.sh` after rendering.
- For persistent issues, remove `_freeze/` and `docs/`, then re-render:
  ```bash
  rm -rf _freeze docs
  quarto render
  ```

## Important Notes

1. Always keep your QMD source files in the `days/` and `slides/` directories
2. The rendered HTML files will be placed in the `docs/` directory
3. Never manually edit files in the gh-pages branch
4. The .nojekyll file is important to ensure proper rendering on GitHub Pages

## License

[Include license information here] 