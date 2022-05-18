
resource "aws_autoscaling_group" "my_asg" {
  depends_on = [
  module.vpc,
  module.alb
]
  name            = "asg-dev"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn
  # Associate ALB with ASG
  target_group_arns         = module.alb.target_group_arns
  initial_lifecycle_hook  {
    
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    }
    

  launch_template {
    id = aws_launch_template.launch_template.id 
    version = aws_launch_template.launch_template.latest_version
    
  }
  # ASG Lifecycle Hooks
 

  instance_refresh  {
    strategy = "Rolling"
    preferences  {
      min_healthy_percentage = 50
    }
    triggers = ["tag", "desired_capacity"] 
  }
}
