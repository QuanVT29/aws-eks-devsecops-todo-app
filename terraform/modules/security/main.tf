# Security Group for Load Balancer (Allows HTTP traffic from anywhere)
resource "aws_security_group" "lb_sg" {
  name   = "${var.project_name}-lb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_sg" {
  name   = "${var.project_name}-ecs-sg"
  vpc_id = var.vpc_id

  # 1. Cho phép ALB kết nối vào Frontend (port 80)
  ingress {
    from_port       = 80 
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id] 
  }

  # 2. Cho phép giao tiếp nội bộ giữa Nginx và Node.js (port 3000)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}