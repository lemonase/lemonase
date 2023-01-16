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

if ! [ -x "$(command -v cowsay)" ]; then
  echo "Please install cowsay"
  exit 1
fi

if ! [ -x "$(command -v fortune)" ]; then
  echo "Please install fortune"
  exit 1
fi

write_readme() {
  cd "$REPO_DIR" || exit 1
  cat README_template.md <(echo '```txt') <(echo "Daily ${COWSAY_TMPL} say for $(date +'%D')") <(fortune | cowsay -f ${COWSAY_TMPL}) <(echo '```') > README.md
  git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push
}

write_readme
