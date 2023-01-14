#!/usr/bin/env bash

# This is a fairly basic script that injects a cowsay after README_template.md file

# Run this from a cron job to update daily:
# Ex: run `crontab -e` and add the path to this script to run everyday at 5 min past midnight
# 5 12 * * * '/path/to/repo/update_readme.sh'

if [ -z "$1" ]; then
  if [ -d "$(dirname -- "$0")" ]; then
    REPO_DIR="$(dirname -- "$(readlink -f  -- "$0";)";)"
  else
    echo "Please supply arg to specify path to repo with GitHub README"
    exit
  fi
else
  REPO_DIR="$1"
fi

if [ -z "$2" ]; then
  COWSAY_TMPL="duck"
else
  COWSAY_TMPL="$2"
fi

cd "$REPO_DIR" || exit
cat README_template.md <(echo '```txt') <(echo "Daily ${COWSAY_TMPL} say for $(date +'%D')") <(fortune | cowsay -f ${COWSAY_TMPL}) <(echo '```') > README.md
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

