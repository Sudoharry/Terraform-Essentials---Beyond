# Cost Estimation for Terraform Plans

This guide outlines two methods for estimating the cost of Terraform plans: **Using Terraform Cloud's Cost Estimation** and **Using Infracost**.

---

## Option 1: Using Terraform Cloud’s Cost Estimation

### 1. Set up a Terraform Cloud account
- Visit [Terraform Cloud](https://app.terraform.io/) and create an account if you don’t have one.

### 2. Connect your Terraform repository
- Link your GitHub, GitLab, or Bitbucket repository containing your Terraform configuration to Terraform Cloud.

### 3. Enable cost estimation
- When creating a new workspace in Terraform Cloud, select the **Cost Estimation** feature.
- Ensure the `terraform plan` command is part of your pipeline. Terraform Cloud will automatically estimate the cost after running the plan.

### 4. Provide AWS credentials (or the respective cloud provider)
- Set up your cloud provider credentials in Terraform Cloud to access resources for cost estimation.

### 5. Run a plan
- Push a change to your Terraform configuration or manually trigger a plan in the Terraform Cloud workspace.
- Review the cost estimation output in Terraform Cloud’s UI.

---

## Option 2: Using Infracost

### 1. Install Infracost
- On your local machine, run the following command to install Infracost:
    ```bash
    curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
    ```
- Verify installation:
    ```bash
    infracost --version
    ```

### 2. Set up an Infracost API key
- Sign up at [Infracost](https://www.infracost.io/) to get your API key.
- Configure the key locally:
    ```bash
    export INFRACOST_API_KEY=your_api_key
    ```

### 3. Initialize your Terraform project
- Navigate to the directory containing your Terraform configuration:
    ```bash
    cd /path/to/your/terraform/configuration
    ```
- Run:
    ```bash
    terraform init
    ```

### 4. Generate a Terraform plan JSON
- Create a plan file:
    ```bash
    terraform plan -out=tfplan.binary
    ```
- Convert it to JSON:
    ```bash
    terraform show -json tfplan.binary > plan.json
    ```

### 5. Run Infracost
- Execute the following to get a detailed cost estimate:
    ```bash
    infracost breakdown --path=plan.json
    ```

### 6. Review the detailed cost estimate
- The cost breakdown will be displayed in your terminal.

### 7. (Optional) Use Infracost in CI/CD
- Integrate Infracost into your CI/CD pipelines to automate cost estimation with pull requests. Follow the [Infracost CI/CD documentation](https://www.infracost.io/docs/integrations/ci_cd/) for setup.

---

## Conclusion

Both **Terraform Cloud’s Cost Estimation** and **Infracost** offer valuable ways to estimate the costs associated with your infrastructure. Terraform Cloud is more integrated, while Infracost provides a more flexible approach, especially for local setups and CI/CD integrations.
