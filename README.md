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

## Rclone

1. Download and extract Rclone on the local machine.

## Preparation

1. Open Powershell on the local machine.

2. Copy the private key `aws.pem` to `~/.ssh`.

3. Create the OpenSSH `config` file on the local machine.

```Powershell
New-Item `
   -Force `
   -Path "~\.ssh" `
   -Name "config" `
   -ItemType "file" `
   -Value (
      "Host *`n  ServerAliveInterval 60`n" +
      "Host aws`n  Hostname ec2-3-228-118-210.compute-1.amazonaws.com`n  User ubuntu`n  IdentityFile ~\.ssh\aws.pem`n"
   )
```

5. Delete the OpenSSH `known_hosts` file on the local machine.

```Shell
rm ~\.ssh\known_hosts*
```

6. Log into the remote machine with OpenSSH.

```Shell
ssh aws
```

7. Update installed packages.

```Shell
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo reboot
```

## Installation

1. Download `prepare.sh` from the vm repo on OneDrive to the local machine.

2. Copy the files from the local machine to VM.

```Shell
cd ~/Downloads
scp prepare.sh aws:~
```

3. Log into VM and prepare for installations.

```Shell
ssh aws
cd ~
bash prepare.sh # Add the SSH key displayed at the end to GitHub.
```

4. Add the SSH key on GitHub.

5. For the first time, run the wrapper script and then log out and back in.

```Shell
cd ~/workspaces/vm/src
bash vm.sh config init
bash vm.sh install all
logout
```

6. To update software, enter new versions and run the update script.

```Shell
cd ~/workspaces/vm/src
bash vm.sh config update
bash vm.sh update all
```

7. To update packages only, run the package script.

```Shell
cd ~/workspaces/vm/src
bash vm.sh package all
```

## Visual Studio Code

1. Install the following extensions in the VS Code on the local machine.

   * "Docker" from Microsoft
   * "ESLint" from Microsoft
   * "IntelliCode" from Microsoft
   * "Julia" from julialang
   * "Jupyter" from Microsoft
   * "Python" from Microsoft
   * "Remote Development" from Microsoft
   * "rust-analyzer" from The Rust Programming Language

2. Connect the VS Code to VM and install the extensions there

3. Open the VS Code settings file.

```Shell
nano ~/.vscode-server/data/Machine/settings.json
```

4. Add the following settings. Enter the full python version for `python.defaultInterpreterPath`.

```JSON
{
   "python.defaultInterpreterPath": "/home/ubuntu/venv/python/${PYTHON_FULL_VERSION}/bin/python",
   "julia.executablePath": "/home/ubuntu/.julia/juliaup/bin/julia"
}
```
