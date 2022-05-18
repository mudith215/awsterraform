# VPC Output Values

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}


output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}


output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}


## pSecurity Group Outputs
output "private_sg_group_name" {
  description = "The name of the security group"
  value       = module.private_sg.security_group_name
}


# Terraform AWS Application Load Balancer (ALB) Outputs
output "lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.lb_id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.lb_arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.alb.lb_dns_name
}

output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = module.alb.target_group_arns
}
