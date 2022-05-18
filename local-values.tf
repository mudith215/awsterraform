locals {

  environment = var.environment

  common_tags = {
    environment = local.environment
  }
} 