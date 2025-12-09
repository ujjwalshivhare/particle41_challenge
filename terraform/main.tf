terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# ------------------- VPC MODULE -------------------
module "vpc" {
  source          = "./modules/vpc"
  name            = "p41-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

# ------------------- ECS MODULE -------------------
module "ecs" {
  source       = "./modules/ecs"
  cluster_name = "p41-ecs"
}

# ------------------- ALB MODULE -------------------
module "alb" {
  source          = "./modules/alb"
  name            = "p41-alb"
  subnets         = module.vpc.public_subnets
  security_groups = [module.vpc.vpc_default_security_group_id]
}

