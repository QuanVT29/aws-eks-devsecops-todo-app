# Create ECR Repository for Frontend Image
resource "aws_ecr_repository" "frontend" {
  name                 = "${var.project_name}-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true # Automatically scan for basic image vulnerabilities on push
  }
}

# Create ECR Repository for Backend Image
resource "aws_ecr_repository" "backend" {
  name                 = "${var.project_name}-backend"
  image_tag_mutability = "IMMUTABLE"

  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  # Encrypt KMS (Fix CKV_AWS_136)
  encryption_configuration {
    encryption_type = "KMS"
  }
}
