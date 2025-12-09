module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name               = var.name
  subnets            = var.subnets
  security_groups    = var.security_groups
  load_balancer_type = "application"
}

