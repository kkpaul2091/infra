## Create Project Directory
```bash
tree /d01/MyWork/1/K8s/ZENPHARMA
├── infra/          # Terraform code (Module 1)
├── frontend/       # Pharma-UI React app (Module 4)
├── backend/        # 8 microservices (Module 7)
└── gitops/         # Helm charts + ArgoCD apps (Module 5)
```
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
## Enable Branch Protection and Approval Process
## 2.4 Enable Branch Protection and Approval Process

Right now, anyone can push directly to `main`, which triggers an immediate apply. That's dangerous — a typo could destroy production infrastructure. We need two safety layers:

1. **Branch protection** — Prevent direct pushes to `main`; require pull requests with passing checks
2. **Environment approval** — Require a human to approve before `terraform apply` runs

### Step 1: Protect the Main Branch

1. Go to your infra repository: `https://github.com/<your-username>/infra`
2. Click **Settings**
3. In the left sidebar, click **Branches** (under "Code and automation")
4. Click **Add branch ruleset** (or **Add classic branch protection rule** if rulesets aren't available)

> **Note:** GitHub recently introduced **Branch rulesets** as the modern replacement for classic branch protection rules. Both work. The instructions below cover the classic approach, which is available on all plan types.

**If using classic branch protection rules:**

4. Click **Add classic branch protection rule**
5. Branch name pattern: `main`
6. Check the following options:

   - **Require a pull request before merging**
     - Set **Required number of approvals** to **0**
     - This forces all changes to go through a PR (so you get the plan review), but does not require someone else to approve it

7. **Do NOT enable** "Require status checks to pass before merging" — leave it unchecked
8. Click **Create** (or **Save changes**)

> **Why set required approvals to 0?**
> We want learners to experience the PR workflow — create a branch, open a PR, see the plan run, review it, then merge. But since you're working solo, requiring an approval from another person would block you. Setting it to 0 means: a PR is required (no direct pushes to `main`), but you can merge it yourself without waiting for a reviewer.
>
> In a real team, you would set this to 1 or 2 so that a colleague reviews every infrastructure change before it goes to `main`.

> **Why NOT require status checks?**
> GitHub matches status checks by their exact name (e.g., `Terraform Infrastructure / Terraform Plan`). If you type the name slightly wrong — different capitalization, missing the workflow prefix, extra spaces — the merge button stays blocked forever, waiting for a check that will never match. This is a common source of confusion. The plan still runs on every PR and you can see the result in the Actions tab before merging. The real safety gate is the **environment approval** on the apply job (next step), which is much harder to misconfigure.

**If using branch rulesets:**

4. Click **Add branch ruleset**
5. Ruleset name: `Protect main`
6. Enforcement status: **Active**
7. Under **Target branches**, click **Add target** > **Include by pattern** > type `main`
8. Under **Rules**, enable:
   - **Require a pull request before merging** (set required approvals to **0**)
9. Click **Create**

