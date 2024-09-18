resource "aws_autoscaling_group" "public_group" {
  count                   = var.public_subnet_count
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.public_tg.arn]
  vpc_zone_identifier       = [aws_subnet.public_subnets[count.index].id]
  metrics_granularity = "1Minute"
  launch_template {
    id      = aws_launch_template.web[count.index].id
    version = aws_launch_template.web[count.index].latest_version
  }
  depends_on = [aws_lb.public_alb]

 tag {
    
      key                 = "Name"
      value               = "web"
      propagate_at_launch = true
    
  }
}


resource "aws_autoscaling_policy" "Target_policy" {
  count                   = var.public_subnet_count
  name                   = "Target_policy"
  autoscaling_group_name = aws_autoscaling_group.public_group[count.index].name
  adjustment_type = "PercentChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 20
    customized_metric_specification {
      metrics {
        label = "alarm Averger network traffic"
        id    = "m1"
        metric_stat {
          metric {
            namespace   = "AWS/AutoScaling"
            metric_name = "NetworkIn"
           dimensions {
            name  = "AutoScalingGroupName"
            value = " terraform-2024090614450661840000000c"
            }
          }
          stat = "Average"
        }
        return_data = true
      }
    }
  }

}


resource "aws_cloudwatch_metric_alarm" "alarm_target" {
  count                   = var.public_subnet_count
  alarm_name                = "alarm-target"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "NetworkIn"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "This metric monitors auroscaling NetworkIn"
  dimensions = {
    TargetGroup  = aws_lb_target_group.public_tg.arn_suffix
    LoadBalancer = aws_lb.public_alb.arn_suffix
  }
  alarm_actions = [ aws_autoscaling_policy.Target_policy[count.index].arn ]
  insufficient_data_actions = []
}
#-----------------------------------------------------------------------------------------#

resource "aws_autoscaling_group" "private_group" {
  count = var.private_subnet_count >= 2 ? 2 : 0
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.private_tg.arn]
  vpc_zone_identifier       = [aws_subnet.private_subnets[count.index].id]
  metrics_granularity = "1Minute"
  launch_template {
    id      = aws_launch_template.app[count.index].id
    version = aws_launch_template.app[count.index].latest_version
  }
  depends_on = [aws_lb.public_alb]

 tag {
    
      key                 = "Name"
      value               = "app"
      propagate_at_launch = true
    
  }
}


resource "aws_autoscaling_policy" "Target_policy2" {
  count = var.private_subnet_count >= 2 ? 2 : 0
  name                   = "Target_policy"
  autoscaling_group_name = aws_autoscaling_group.private_group[count.index].name
  adjustment_type = "PercentChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 20
    customized_metric_specification {
      metrics {
        label = "alarm Averger network traffic"
        id    = "m1"
        metric_stat {
          metric {
            namespace   = "AWS/AutoScaling"
            metric_name = "NetworkIn"
           dimensions {
            name  = "AutoScalingGroupName"
            value = " terraform-2024090614450661840000000c"
            }
          }
          stat = "Average"
        }
        return_data = true
      }
    }
  }

}


resource "aws_cloudwatch_metric_alarm" "alarm_target2" {
  count = var.private_subnet_count >= 2 ? 2 : 0
  alarm_name                = "alarm-target"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "NetworkIn"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "This metric monitors auroscaling NetworkIn"
  dimensions = {
    TargetGroup  = aws_lb_target_group.private_tg.arn_suffix
    LoadBalancer = aws_lb.private_alb.arn_suffix
  }
  alarm_actions = [ aws_autoscaling_policy.Target_policy2[count.index].arn ]
  insufficient_data_actions = []
}