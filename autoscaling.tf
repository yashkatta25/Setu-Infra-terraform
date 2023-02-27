resource "aws_appautoscaling_target" "q2-ecs-target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.q2-ecs-cluster.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "q2-ecs-policy-memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.q2-ecs-target.resource_id
  scalable_dimension = aws_appautoscaling_target.q2-ecs-target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.q2-ecs-target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageMemoryUtilization"
   }
   target_value       = 80
  }
}
 
resource "aws_appautoscaling_policy" "q2-ecs-policy-cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.q2-ecs-target.resource_id
  scalable_dimension = aws_appautoscaling_target.q2-ecs-target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.q2-ecs-target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageCPUUtilization"
   }
   target_value       = 60
  }
}