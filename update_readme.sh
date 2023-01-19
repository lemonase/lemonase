#!/bin/bash

# This is a fairly basic script that injects a cowsay after README_template.md file

# Run this from a cron job to update daily:
# Ex: run `crontab -e` and add the path to this script to run everyday at 5 min past midnight
# 5 12 * * * '/path/to/repo/update_readme.sh'

LOG_FILE="/tmp/cronsay.log"
REPO_DIR="$(dirname -- $0)"

cd "$REPO_DIR" || exit 1
cat README_template.md <(echo '```txt') <(echo "Daily ${COWSAY_TMPL} say for $(date +'%D')") <(fortune | cowsay -f ${COWSAY_TMPL}) <(echo '```') > README.md
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

echo "Daily cowsay ran $(date)" >> /tmp/cronsay.log
