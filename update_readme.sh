#!/usr/bin/env bash

# This is a fairly basic script that injects a cowsay after README_template.md file

# Run this from a cron job to update daily:
# Ex: run `crontab -e` and add the path to this script to run everyday at 5 min past midnight
# 5 12 * * * '/path/to/repo/update_readme.sh'

REPO_DIR="$HOME/Code/lemonase"
COWSAY_TMPL="duck"

cd "$REPO_DIR" || exit
cat README_template.md <(echo '```txt') <(echo "Daily ${COWSAY_TMPL} say for $(date +'%D')") <(fortune | cowsay -f ${COWSAY_TMPL}) <(echo '```') > README.md
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

