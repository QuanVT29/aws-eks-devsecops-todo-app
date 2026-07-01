# 1. ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

# 2. Task Definition (declare docker image)
resource "aws_ecs_task_definition" "app" {
  family                   = "todo-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
  {
    name  = "frontend"
    image = "222634368199.dkr.ecr.us-east-1.amazonaws.com/todo-frontend:latest"
    portMappings = [{ containerPort = 80, hostPort = 80 }] # frontend port 80
  },
  {
    name  = "backend"
    image = "222634368199.dkr.ecr.us-east-1.amazonaws.com/todo-backend:latest"
    portMappings = [{ containerPort = 3000, hostPort = 3000 }]
  }
])
}

# 3. ECS Service (Connect Task with VPC and Security Group)
resource "aws_ecs_service" "app" {
  name            = "todo-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }
}