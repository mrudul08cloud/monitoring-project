provider "aws" {
  region = "ap-south-1"
}

# S3 bucket for tfstate
resource "aws_s3_bucket" "tf_state" {
  bucket = "todo-eks-tfstate-bucket-12345"

  tags = {
    Name = "terraform-state"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for state lock
resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
