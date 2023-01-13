TMPL="duck"
cat README_template.md <(echo '```txt') <(echo "Daily ${TMPL} say for $(date +'%D')") <(fortune | cowsay -f $TMPL) <(echo '```') > README.md
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

