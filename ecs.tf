resource "aws_ecs_cluster" "q2-ecs-cluster" {
  name =  var.project_name
}

resource "aws_ecs_task_definition" "q2-task" {
  family                   = "helloWorld"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
      {
          name          = "helloWorld"
          image         = var.image
          essential     = true
          portMappings = [{
             protocol      = "tcp"
            containerPort = 80
            hostPort      = 80
            }]
      }
  ])
}

resource "aws_ecs_service" "main" {
 name                               =  var.project_name
 cluster                            = aws_ecs_cluster.q2-ecs-cluster.id
 task_definition                    = aws_ecs_task_definition.q2-task.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.q2-ecs-tasks.id]
   subnets          = [aws_subnet.privet-subnet1.id, aws_subnet.privet-subnet1.id]
   assign_public_ip = false
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.q2-lb-tg.id
   container_name   = "helloWorld"
   container_port   = 80
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}
