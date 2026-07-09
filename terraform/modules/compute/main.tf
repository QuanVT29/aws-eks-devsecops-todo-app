# 1. ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

# NEW: CloudWatch Log Group to store container logs
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

# 2. IAM Role for ECS Task Execution 
# Grants ECS permission to pull images from ECR and write logs to CloudWatch
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 3. Task Definition (Multi-container architecture: Frontend + Backend)
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"  # Total CPU for both containers
  memory                   = "1024" # Total RAM for both containers
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "222634368199.dkr.ecr.us-east-1.amazonaws.com/todo-backend:v1"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "MONGO_URI"
          # Connected successfully using your MongoDB Atlas string
          value = "mongodb+srv://todo_user:TodoUser2026Password@cluster0.wa1yhzj.mongodb.net/todo-db?retryWrites=true&w=majority&appName=Cluster0"
        }
      ]
      # Added: Send backend container stdout/stderr to CloudWatch
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "backend"
        }
      }
    },
    {
      name      = "frontend"
      image = "222634368199.dkr.ecr.us-east-1.amazonaws.com/todo-frontend:v1"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      # Frontend depends on the backend, which must start first
      dependsOn = [
        {
          containerName = "backend"
          condition     = "START"
        }
      ]
      # Added: Send frontend container (Nginx) logs to CloudWatch
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "frontend"
        }
      }
    }
  ])
}

# 4. ECS Service (Updated to include Load Balancer connection)
resource "aws_ecs_service" "app_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.public_subnets
    security_groups  = [var.ecs_security_group_id]
    # Đổi từ false sang true để nhận IP công khai kết nối được tới MongoDB Atlas
    assign_public_ip = true   
  }

  # Connect ECS Service to the Application Load Balancer
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "frontend"
    container_port   = 80
  }

  # Ensure the Load Balancer Listener is created before the ECS Service
  depends_on = [aws_lb_listener.http]
}

# ---------------------------------------------------------
# NEW: Application Load Balancer (ALB) Setup
# ---------------------------------------------------------

# 5. Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false # Set to false to allow public internet access
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.public_subnets
}

# 6. Target Group (Points ALB traffic to ECS tasks)
resource "aws_lb_target_group" "app" {
  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302" # Accept standard HTTP success codes
  }
}

# 7. ALB Listener (Listens for incoming traffic on port 80)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}