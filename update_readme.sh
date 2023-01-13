TMPL="duck"
cat README_template.md <(echo "Daily ${TMPL} say for $(date +'%D')") <(fortune | cowsay -f $TMPL) > README.md
git add README.md && git commit -m "Daily cowsay for $(date +"%Y-%m-%d")" && git push

