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
## check project-level roles:

```bash 
PROJECT_ID=$(gcloud config get-value project)

gcloud projects get-iam-policy ${PROJECT_ID} \
  --flatten="bindings[].members" \
  --filter="bindings.members:terraform-sa@${PROJECT_ID}.iam.gserviceaccount.com" \
  --format="table(bindings.role)"
```
```doc
ROLE
roles/artifactregistry.admin
roles/compute.networkAdmin
roles/container.admin
roles/editor
roles/iam.serviceAccountAdmin
roles/secretmanager.admin
```

