#!/usr/bin/env bash

# This is a script that injects a cowsay after README_template.md file
# Run this from a cron job to update daily

# move into repo directory
cd "$HOME/Code/lemonase"

# append fortune | cowsay command to README_template.md and out the actual README.md file
TMPL="duck"
cat README_template.md <(echo '```txt') <(echo "Daily ${TMPL} say for $(date +'%D')") <(fortune | cowsay -f $TMPL) <(echo '```') > README.md

# add README.md, commit with message and push to GitHub
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

