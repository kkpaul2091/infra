```bash
git init
git status 
git add .
git commit  -m "INFRA : $(date '+ %A, %B %d, %Y at %I:%M %p')"
git branch -M main
git remote add origin https://kkpaul2091@github.com/kkpaul2091/infra.git
git push -u origin main
------
git status 
git branch 
git checkout -b feat/setup
git add . 
git status 
git commit -m "INFRA : $(date '+ %A, %B %d, %Y at %I:%M %p')"
git push origin feat/setup
```
