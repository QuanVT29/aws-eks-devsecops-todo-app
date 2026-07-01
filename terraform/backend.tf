terraform {
  backend "s3" {
    bucket         = "my-terraform-bucket2911" 
    key            = "todo-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"            
    encrypt        = true
  }
}