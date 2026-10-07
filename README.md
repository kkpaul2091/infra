```bash
git init
git status 
git add .
git commit  -m "INFRA : $(date '+ %A, %B %d, %Y at %I:%M %p')"
git branch -M main
git remote add origin https://kkpaul2091@github.com/kkpaul2091/infra.git
git push -u origin main
------
## GKE Infrastructure Deployment Process
```
```text
Create Feature Branch (feat/setup)
                │
                ▼
            Git Push
                │
                ▼
      Pull Request to main
                │
                ▼
          Terraform Plan
                │
                ▼
        Reviewer Approval
                │
                ▼
             Merge PR
                │
                ▼
           Push to main
                │
                ▼
          Terraform Plan
                │
                ▼
      Environment Approval
                │
                ▼
          Terraform Apply
```

### Workflow Summary

1. Create a feature branch from `main`.
2. Commit and push Terraform changes.
3. Open a Pull Request targeting `main`.
4. GitHub Actions executes `terraform plan`.
5. Reviewers validate the Terraform plan and approve the PR.
6. Merge the PR into `main`.
7. A new workflow is triggered on the `main` branch.
8. Terraform plan is generated again.
9. Environment approval is required before deployment.
10. Terraform apply deploys the infrastructure to GKE.
```bash 
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

