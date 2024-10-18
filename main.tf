terraform {
  required_version = ">=1.8.3"
  required_providers {
    aws = ">=5.70.0"
    }
  }

provider "aws" {
  region = "us-east-1"
  }

  module "vpc" {
    source = "./modules/vpc"
    prefix = var.prefix
    vpc-cidr-block = var.vpc-cidr-block
    subnet-cidr-block = var.subnet-cidr-block
  }

  module "security_group" {
    source = "./modules/security_group"
    vpc-id = module.vpc.vpc-id
    prefix = var.prefix
  }

  module "ec2" {
    source        = "./modules/ec2"
    prefix = var.prefix
    subnet-id     = module.vpc.subnet-id
    security-group-id = module.security_group.security-group-id
    key-name      = var.key-name
  }
