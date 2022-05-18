resource "aws_autoscaling_policy" "high_cpu" {
  name                   = "high-cpu"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_asg.name 
}

resource "aws_cloudwatch_metric_alarm" "asg_cwa_high_cpu" {
  alarm_name          = "EC2-high-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name 
  }

  alarm_description = "scale-out if CPU is above 80%"
  
  
  alarm_actions     = [aws_autoscaling_policy.high_cpu.arn] 
 
}

resource "aws_autoscaling_policy" "low_cpu" {
  name                   = "low-cpu"
  scaling_adjustment     = -2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_asg.name 
}

resource "aws_cloudwatch_metric_alarm" "asg_cwa_low_cpu" {
  alarm_name          = "EC2-low-CPUUtilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name 
  }

  alarm_description = "scale-out if CPU is below 60%"
  
  
  alarm_actions     = [aws_autoscaling_policy.low_cpu.arn] 
 
}

