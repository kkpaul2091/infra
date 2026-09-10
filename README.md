```bash
cd /d01/MyWork/1/K8s/ZENPHARMA/infra
echo "# infra" >> README.md
git init
git status 
git add .
git commit  -m "KKP Commit initiated at: $(date '+ %A, %B %d, %Y at %I:%M %p')"
git branch -M main
git remote add origin https://kkpaul2091@github.com/kkpaul2091/infra.git
git push -u origin main
```
