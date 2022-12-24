## General information

Main development resources consist of the following:

* virtual machines on AWS EC2
* docker images on AWS ECR
* clusters on AWS ECS
* buckets on AWS S3
* code repositories on GitHub
* backup folders on OneDrive

## AWS EC2

1. Go to `IAM`. Add a user `aws` for programmatic access with the following permissions policies: AmazonEC2ContainerRegistryFullAccess, AmazonEC2FullAccess, AmazonECS_FullAccess, AmazonS3FullAccess, AmazonSSMFullAccess and IAMFullAccess. Download user credentials to the local machine.

2. Create a role `ec2` for the entity type `AWS Service` and use case `EC2` with the following permissions policies: AmazonEC2ContainerRegistryFullAccess, AmazonEC2FullAccess, AmazonECS_FullAccess, AmazonS3FullAccess, AmazonSSMFullAccess and IAMFullAccess.

3. Go to `EC2`. Create a key pair with the name `aws`, type `ED25519` and format `.pem`. Download the private key to the local machine.

4. Add an inbound rule for the type `SSH` and source `Anywhere-IPv4` to the `default` security group.

5. Allocate an elastic IP address.

6. Create a launch template `c7g.2xlarge-on-demand` or else with the image `ubuntu`, type `c7g.2xlarge` or else, key pair `aws`, security group `default`, storage `30GiB` `gp3`, purchasing option `on-demand` and IAM instance profile `ec2`.

7. Launch an instance from the launch template. Associate an available elastic IP address to this instance.

## AWS ECS

1. Go to `IAM`. Create a role `ecs-tasks` for the entity type `AWS Service` and use case `Elastic Container Service Task` with the following permissions policies: AmazonECSTaskExecutionRolePolicy and AmazonSSMFullAccess.

2. Skip this step if you are going to use AWS Fargate. Go to `EC2`. Create a launch template `funds-allocation` or else with the image `amzn2-ami-ecs-hvm-2.0.20221213-arm64-ebs` or later, type `r6g.8xlarge` or else, key pair `aws`, security group `default`, storage `30GiB` `gp3`, purchasing option `spot` and IAM instance profile `ecs-tasks`.

3. Go to `ECR`. Create a repository with the visibility setting `private` and name `funds-allocation` or else.

4. Go to `ECS`. Create a task definition with the family `funds-allocation`, container name `container`, image uri from the ECR repository, task role `ecs-tasks`, task execution role `ecs-tasks` and use log collection `checked`.
