terraform {
  backend "s3" {
    bucket         = "my-terraform-bucket2911" 
    key            = "todo-app/terraform.tfstate"
    region         = "ap-southeast-1"
    use_lockfile   = true           
    encrypt        = true
  }
}