# Terraform EKS Cluster with Reusable Modules

This project provides a set of reusable Terraform modules to create and manage an Amazon EKS (Elastic Kubernetes Service) cluster. The project is structured to promote modularity and reusability, with a clear separation of concerns between the EKS cluster and its underlying network infrastructure.

## Project Structure

The project is organized into two main directories:

-   `modules/`: This directory contains the reusable Terraform modules.
    -   `eks/`: A module for creating and managing an EKS cluster.
    -   `vpc/`: A module for creating a VPC. This module is primarily for testing and can be replaced with your own VPC infrastructure.
-   `infrastructure/`: This directory contains the root Terraform configuration that uses the modules to provision the EKS cluster and its dependencies.

## EKS Module

The `eks` module is the core of this project. It creates an EKS cluster with a default node group.

### Usage

To use the `eks` module, you can call it from your Terraform configuration as follows:

```terraform
module "eks" {
  source = "./modules/eks"

  cluster_name                 = "my-eks-cluster"
  SSO_AdministratorAccess_role = "arn:aws:iam::123456789012:role/AWSReservedSSO_AWSAdministratorAccess_xxxx"
  vpc_id                       = "vpc-12345678"
  private_subnets              = ["subnet-12345678", "subnet-87654321"]
}
```

### Inputs

The `eks` module accepts the following input variables:

| Name                           | Description                                           | Type         | Default | Required |
| ------------------------------ | ----------------------------------------------------- | ------------ | ------- | :------: |
| `cluster_name`                 | The name of the EKS cluster.                          | `string`     | n/a     |   yes    |
| `SSO_AdministratorAccess_role` | The ARN of the SSO AdministratorAccess role.          | `string`     | n/a     |   yes    |
| `vpc_id`                       | The ID of the VPC where the cluster will be deployed. | `string`     | n/a     |   yes    |
| `private_subnets`              | A list of private subnets for the EKS cluster.        | `list(string)` | n/a     |   yes    |

### Outputs

The `eks` module provides the following outputs:

| Name                                 | Description                                                                    |
| ------------------------------------ | ------------------------------------------------------------------------------ |
| `cluster_endpoint`                   | The endpoint for your EKS cluster.                                             |
| `cluster_certificate_authority_data` | The base64 encoded certificate data required to communicate with your cluster. |
| `cluster_name`                       | The name of the EKS cluster.                                                   |

## VPC Module

The `vpc` module is provided for testing purposes. It creates a VPC with public and private subnets. You can replace this module with your own VPC infrastructure.

## Running the Project

To run this project, navigate to the `infrastructure` directory and run the following commands:

1.  **Initialize Terraform:**

    ```bash
    terraform init
    ```

2.  **Plan the deployment:**

    ```bash
    terraform plan
    ```

3.  **Apply the configuration:**

    ```bash
    terraform apply
    ```
