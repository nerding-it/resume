#!/usr/bin/env bash

SRC=content/resume
FOLDER=examples/latex
DEST=$FOLDER/resume

# Ensure Examples Folder Exists
mkdir -p $FOLDER >> /dev/null

# Generate PDF
# https://emacs.stackexchange.com/a/10428/18882
yes | emacs \
    -u "$(id -un)" \
    --batch \
    --eval '(load user-init-file)' \
    $SRC.org \
    -f org-latex-export-to-pdf


# Move PDF
mv $SRC.pdf $DEST.pdf
mv $SRC.tex $DEST.tex

# Convert to PNG
convert -density 300 -background white -alpha off $DEST.pdf $DEST.png
convert -geometry 800x +repage $DEST.png $DEST.png

# Crop top of PNG
convert $DEST.png +repage -gravity South -crop 800x1000+0+0 +repage $DEST.png
