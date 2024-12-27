# Secure Management of Sensitive Data in Terraform

When working with Terraform, it's essential to securely manage sensitive data like API keys, credentials, and tokens. Hardcoding sensitive information in Terraform configuration files is not a recommended practice due to security risks. Instead, there are several strategies you can employ to keep this information secure, such as using environment variables, integrating with secrets management tools (e.g., AWS Secrets Manager or HashiCorp Vault), and using Terraform's built-in sensitive variables.

## 1. Using Environment Variables

One common method to avoid hardcoding sensitive information in your Terraform files is to use environment variables to store secrets like API keys, credentials, or tokens.

### Example: Using Environment Variables with Terraform

#### Step 1: Set the Environment Variables

On a Linux or macOS system, you can set an environment variable in the terminal:

```bash
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```

On Windows (PowerShell), you can set environment variables like this:

```powershell
$env:AWS_ACCESS_KEY_ID="your-access-key-id"
$env:AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```

# 2. Using Terraform Sensitive Variables

Terraform allows you to define variables as sensitive, ensuring that the values are not exposed in logs or plan outputs.

## Example: Defining Sensitive Variables in Terraform

### Step 1: Define Sensitive Variables

In your `variables.tf` file, define the variable as sensitive:

```hcl
variable "my_sensitive_variable" {
  description = "This is a sensitive variable"
  type        = string
  sensitive   = true
}

# Passing Sensitive Data in Terraform

## Step 2: Pass the Sensitive Data

You can pass the value of the sensitive variable via environment variables, a `.tfvars` file, or directly in the Terraform `apply` command.

### Using `.tfvars` File

Store sensitive values securely in a `.tfvars` file (be sure to exclude it from version control by adding it to `.gitignore`).

```hcl
# secrets.tfvars
api_key = "your-api-key"
```

# Using Sensitive Variables in Terraform Configuration

## Step 3: Use the Sensitive Variable in Terraform Configuration

You can reference the sensitive variable in your resource block, and Terraform will hide the value in the output.

```hcl
resource "aws_secretsmanager_secret" "example" {
  name = "api_key_secret"

  secret_string = var.api_key
}
```

![encry-key-secret-name](https://github.com/user-attachments/assets/c60217f7-d9d1-4492-9b3f-08de07f93095)

---
![key-generataed](https://github.com/user-attachments/assets/0b67f7d9-de9c-4568-9776-b53640028b4d)

---
![Secret-management-using-AWS](https://github.com/user-attachments/assets/527c67da-419e-4830-b854-cda728e97b0e)

---
![Lifecycle-terraform](https://github.com/user-attachments/assets/d7c357a0-b12f-4387-a404-6fe754f76f82)




