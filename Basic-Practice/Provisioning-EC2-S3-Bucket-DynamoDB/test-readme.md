# Terraform Infrastructure Provisioning Test Documentation

## Overview

This documentation explains the process of testing Terraform's provisioning and management of AWS resources such as EC2 instances, S3 buckets, and DynamoDB tables. The test ensures that Terraform is able to correctly initialize the configuration, apply the necessary changes, and retrieve output variables.

## Test Objective

The objective of this test is to validate that the Terraform configuration:

- Initializes the required provider (AWS).
- Applies the configuration to provision or refresh the state of the resources.
- Retrieves the expected output variables (such as EC2 instance IDs).

## Test Workflow

### 1. **Test Setup**

The test begins by running the following Go test command:

```bash
go test -v
```

This command runs the test with verbose logging, providing detailed output for each step. The test is executed in the local environment where Terraform and Go are installed and properly configured.

### 2. Terraform Initialization
 Command: terraform init

 Purpose: Initializes the Terraform working directory by downloading required provider plugins and setting up the backend configuration.

 Key Logs:

  - Reusing previously installed AWS provider (hashicorp/aws).
  - Terraform has been successfully initialized!

 The initialization ensures that Terraform is ready to interact with AWS services. It verifies that the required provider (hashicorp/aws) is available, and the environment is set up to apply configurations.

### 3. Terraform Apply
  Command: terraform apply

  Purpose: Applies the Terraform configuration to create or modify resources based on the defined infrastructure. If there are no changes required (i.e., the state is up-to-date), Terraform will inform you that no changes are needed.

  Key Logs:

 Terraform compares the real infrastructure with the configuration.
   No changes. Your infrastructure matches the configuration.

 In this step, Terraform compares the actual state of the infrastructure with the defined configuration. If no differences are found between the configuration and the current state, Terraform outputs No changes. Your infrastructure matches the configuration, confirming that no action is required.

### 4. Output Retrieval
  Command: terraform output -json instance_id

  Purpose: Fetches the output variables defined in the Terraform configuration, in this case, the instance_id of the provisioned EC2 instance.

  Key Logs:

 makefile

 Outputs:
 instance_id = "i-0285eed1b304245a7"
 The output command retrieves the value of the instance_id that was provisioned in the previous step. The expected output is the EC2 instance ID (i-0285eed1b304245a7), confirming that the EC2 instance has been successfully created and is managed by Terraform.

### 5. Test Completion
  Status: PASS

  Summary: The test completes successfully, confirming that no changes were required, and the expected output (EC2 instance ID) was returned. The infrastructure is in the expected state, and Terraform managed the provisioning and output retrieval processes efficiently.

  Final Output

  The test verifies that the infrastructure is correctly provisioned, and that the EC2 instance ID is properly output by Terraform. The test is considered successful if the output matches the expected results. A successful test will display the instance ID as shown below:

makefile

   instance_id = "i-0285eed1b304245a7"
   This output confirms that the EC2 instance was successfully created or already exists as defined in the Terraform configuration.

### Key Takeaways
- Terraform successfully initialized and applied the configuration without any changes.
- The EC2 instance ID was correctly retrieved, confirming that Terraform is properly managing the AWS resources.
- The test execution process takes approximately 6 seconds.

### Conclusion
- This test ensures that Terraform is able to provision and manage AWS resources effectively. It validates the core functionality of Terraform commands like init, apply, and output in the context of managing infrastructure resources like EC2, S3, and DynamoDB.

The test demonstrates Terraform’s ability to:

- Initialize a working environment.
- Apply infrastructure changes when needed.
- Retrieve relevant outputs like resource IDs.

  - By following this workflow, you can confidently manage and provision AWS resources using Terraform in a consistent and automated manner.

How to Run the Test
Clone the Repository:

```bash
git clone <repository-url>
cd <repository-directory>
```
- Install Dependencies:

 - Ensure that you have Go installed on your system.
 - Make sure Terraform is installed and configured to use your AWS credentials.

Run the Go Test:

```bash
go test -v
```

 - Review the Logs: The logs will display detailed information about the Terraform initialization, apply steps, and output retrieval.


-  Prerequisites

 - Go: Go should be installed on your local machine. You can download it from here.
 - Terraform: Terraform should be installed and configured. Follow the instructions here to install Terraform.

 - AWS Credentials: Ensure that your AWS credentials are set up correctly for Terraform to interact with AWS resources.

Resources Provisioned
 - EC2 Instance: A basic EC2 instance with the type t2.micro.
 - S3 Bucket: A bucket for storing Terraform state files.
  - DynamoDB Table: A table used to store Terraform state lock information.
