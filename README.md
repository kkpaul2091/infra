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

### Step 2: Create the GitHub Environment

GitHub Environments provide **deployment protection rules** — most importantly, required reviewers. When a workflow job references an environment, it pauses and waits for an approved reviewer to click "Approve" before continuing.

1. Go to your infra repository: `https://github.com/kkpaul2091/infra`
2. Click **Settings**
3. In the left sidebar, click **Environments** (under "Code and automation")
4. Click **New environment**
5. Name: `dev`
6. Click **Configure environment**
7. Under **Deployment protection rules**, check **Required reviewers**
8. In the search box, add yourself (your GitHub username) as a reviewer
9. Click **Save protection rules**

> **Why a `dev` environment with approval?** Our workflow's apply job has `environment: dev`. When this job runs, GitHub sees the environment protection rules and pauses the workflow. A notification is sent to the required reviewers. Only after a reviewer clicks "Approve and deploy" does the apply job proceed. This gives you a final checkpoint to review the plan output before applying changes to real infrastructure.
>
> **In a real team setup**, you would add senior engineers or a platform team as reviewers. For this course, you are both the author and the reviewer.
## 2.3 Adding Secrets and Variables to GitHub

Now that you've seen the workflow, you'll notice it references secrets like `${{ secrets.AWS_ACCESS_KEY_ID }}` and variables like `${{ vars.GH_ORG }}`. These need to be configured in GitHub before the workflow can run. GitHub provides two mechanisms: **Secrets** (encrypted, hidden in logs) and **Variables** (plaintext, visible in logs).

### Understanding Secrets vs. Variables

> **Secrets** are for sensitive values like passwords and access keys. They are encrypted at rest, never shown in workflow logs (GitHub automatically masks them), and cannot be read back after being set — only overwritten.
>
> **Variables** are for non-sensitive configuration like region names, bucket names, and organization names. They are stored in plaintext, visible in logs, and can be read back in the GitHub UI.
>
> **Rule of thumb:** If you would be uncomfortable seeing the value in a public build log, use a secret. Otherwise, use a variable.

### Step 1: Add Repository Secrets

1. Go to your infra repository: `https://github.com/kkpaul2091/infra`
2. Click **Settings** (you need admin access)
3. In the left sidebar, expand **Secrets and variables** and click **Actions**
4. You'll see two tabs at the top: **Secrets** and **Variables**
5. On the **Secrets** tab, click **New repository secret**

**Secret 1: AWS_ACCESS_KEY_ID**
- Name: `AWS_ACCESS_KEY_ID`
- Secret: Paste your IAM user's Access Key ID (from Module 1.1)
- Click **Add secret**

**Secret 2: AWS_SECRET_ACCESS_KEY**
- Name: `AWS_SECRET_ACCESS_KEY`
- Secret: Paste your IAM user's Secret Access Key
- Click **Add secret**

**Secret 3: DEV_DB_PASSWORD**
- Name: `DEV_DB_PASSWORD`
- Secret: A strong password for your dev database (e.g., `MyDevDb#2025!Secure`)
- Click **Add secret**

> **Important:** Use a strong password with uppercase, lowercase, numbers, and special characters. AWS RDS rejects weak passwords. Do NOT use quotes or backslashes in the password — they can cause escaping issues in shell commands.

**Secret 4: DEV_JWT_SECRET**
- Name: `DEV_JWT_SECRET`
- Secret: A random string for JWT signing (e.g., `dev-jwt-secret-zenpharma-2025`)
- Click **Add secret**

You should now see 4 secrets listed:

```
AWS_ACCESS_KEY_ID       Updated just now
AWS_SECRET_ACCESS_KEY   Updated just now
DEV_DB_PASSWORD         Updated just now
DEV_JWT_SECRET          Updated just now
```
> **Why static access keys instead of OIDC?** The ideal approach for GitHub Actions to access AWS is through OIDC federation — no static credentials to rotate. However, OIDC federation requires a GitHub Actions OIDC provider configured in IAM. Our Module 1 IAM module created this provider, but to use it we'd need to configure `aws-actions/configure-aws-credentials` with a role ARN and `role-to-assume`. For simplicity in this course, we use static access keys. In a production environment, you would use OIDC.

### Step 2: Add Repository Variables

1. On the same page (**Settings** > **Secrets and variables** > **Actions**), click the **Variables** tab
2. Click **New repository variable**

**Variable 1: GH_ORG**
- Name: `GH_ORG`
- Value: Your GitHub username or organization name (e.g., `zenpharma`)
- Click **Add variable**

**Variable 2: TF_STATE_BUCKET**
- Name: `TF_STATE_BUCKET`
- Value: Your S3 bucket name from Module 1.4 (e.g., `zen-pharma-terraform-state-<your-name>`)
- Click **Add variable**

You should now see 2 variables listed:

```
GH_ORG              zenpharma
TF_STATE_BUCKET     zen-pharma-terraform-state-<your-name>
```
## 2.5 Run Terraform Through GitHub Actions

Now let's test the full workflow by pushing a change through the CI pipeline.

### Step 1: Create a Feature Branch

Since we enabled branch protection, we can no longer push directly to `main`. All changes must go through a pull request.

```bash
cd /d01/MyWork/1/K8s/ZENPHARMA/infra
git checkout -b feat/trigger-ci
```

### Step 2: Make a Small Change

We need to change a file under `envs/dev/` or `modules/` to trigger the workflow (path filtering). Let's add a comment to the main Terraform configuration:

```bash
code /d01/MyWork/1/K8s/ZENPHARMA/infra/envs/dev/main.tf
```

Add a comment at the top of the file:

```hcl
# ZenPharma Dev Environment — managed via GitHub Actions CI/CD
locals {
  project = "pharma"
  env     = "dev"
  region  = "ap-southeast-2"
}
...
```

### Step 3: Commit and Push the Feature Branch

```bash
cd /d01/MyWork/1/K8s/ZENPHARMA/infra
git add envs/dev/main.tf
git commit -m "ci: trigger initial CI pipeline run"
git push origin feat/trigger-ci
```

### Step 4: Create a Pull Request

**Option A — GitHub CLI:**

```bash
gh pr create \
  --title "ci: trigger initial terraform CI pipeline" \
  --body "Trigger the Terraform GitHub Actions workflow to verify the pipeline works end-to-end." \
  --base main
```
