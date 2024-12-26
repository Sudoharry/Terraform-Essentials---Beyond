
# Configure the GitHub Provider
terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = "~> 6.4.0"  # Updated version
    }
  }
}

provider "github" {
  token = var.github_token
}

# Define the GitHub repository (using your existing repository)
resource "github_repository" "example_repo" {
  name        = "GitHub-Actions-Labs"  # Using your existing repo
  description = "A sample repository to demonstrate GitHub Actions with Terraform"
  visibility  = "public"
}

# Adding a GitHub Actions Workflow File to your existing repository
resource "github_repository_file" "workflow_file" {
  repository    = github_repository.example_repo.name  # Directly referencing your existing repository
  file          = ".github/workflows/first-actions.yml"
  content       = <<EOT
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16'

      - name: Install Dependencies
        run: npm install

      - name: Run Tests
        run: npm test
EOT
  branch         = "main"
  commit_message = "Add GitHub Actions workflow file"
  overwrite_on_create = true 
}

# Output the repository URL
output "repository_url" {
  value = github_repository.example_repo.html_url
}
