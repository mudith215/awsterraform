module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.10.0"
  # insert the 4 required variables here
name = "application-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  security_groups = [module.loadbalancer_sg.security_group_id]
  # Listeners
http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      # action_type        = "forward"
    },
]
# Target Groups
  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "apps"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
            protocol_version = "HTTP1"
     },  
  ]
}