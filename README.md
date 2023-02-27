# Setu-Infra-terraform

### Steps to Recreate it:

Step 1. $terraform init

Step 2. $terraform plan


Terraform Manifest files will create following resources:

1. VPC [Public Subnet and Private Subnet, Route tables]
2. ALB - [Listener, Target Group]
3. ECS Cluster
4. AutoScaling Policy [CPU, Memory]
5. Elastic IP
6. NAT
7. IGW
8. IAM task Execution role & Policy
9. Bastion Host [keys, Sg-groups]
10. RDS


