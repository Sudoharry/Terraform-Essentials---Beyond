package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert" // Importing the assert package
)

func TestTerraformExampleV2(t *testing.T) {
	t.Parallel()

	// Define the Terraform options
	options := &terraform.Options{
		TerraformDir: "/workspaces/Terraform-Labs/Basic-Practice/Provisioning-EC2-S3-Bucket-DynamoDB", // Ensure the path is correct
		Vars: map[string]interface{}{
			"region":        "ap-south-1",
			"instance_type": "t2.micro",
		},
		NoColor: true, // Disable color in Terraform commands
	}

	// Initialize and apply the Terraform code
	terraform.InitAndApply(t, options)

	// Validate your code works as expected
	output := terraform.Output(t, options, "instance_id")

	// Assert that the instance ID is not empty
	assert.True(t, len(output) > 0, "Instance ID should not be empty")
}
