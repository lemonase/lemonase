#!/bin/bash

# This is a fairly basic script that injects a cowsay after README_template.md file

# Run this from a cron job to update daily:
# Ex: run `crontab -e` and add the path to this script to run everyday at 5 min past midnight
# 5 12 * * * '/path/to/repo/update_readme.sh'

DAILY_COWSAY="/tmp/cowsay-daily.txt"
REPO_DIR="$(dirname -- $0)"

echo '```txt' > $DAILY_COWSAY
echo "Daily cowsay for $(date +'%D')" >> $DAILY_COWSAY
(/usr/games/fortune | /usr/games/cowsay) >> $DAILY_COWSAY
echo '```' >> $DAILY_COWSAY

cd "$REPO_DIR" || exit 1
cat README_template.md $DAILY_COWSAY > README.md

git add README.md && git commit -m "Daily cowsay for $(date +'%Y-%m-%d')" && git push
