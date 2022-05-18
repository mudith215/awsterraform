# Generic Variables
aws_region = "us-east-1"
environment = "dev"
# EC2 Instance Variables
instance_type = "t3.micro"
instance_keypair = "terraform-key"
# VPC Variables
vpc_name = "myvpc"
vpc_cidr_block = "10.0.0.0/16"
vpc_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true