// S3 bucket for website.
resource "aws_s3_bucket" "P3-Prod-FE-Bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "P3-Prod-FE"
    Environment =  "Prod"
  }
}

//Enable web hosting option, setup index and error file
resource "aws_s3_bucket_website_configuration" "web_hosting" {
  bucket = var.bucket_name
  index_document {
    suffix = "index.html"
  }
  
  error_document {
    key = "index.html"
  }
}

//disable private access, make s3 public
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.P3-Prod-FE-Bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  
}

//update bucket policy, depending on ./s3-policy.json
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.P3-Prod-FE-Bucket.id
  policy = templatefile("${path.module}/s3-policy.json", { bucket = var.bucket_name})
}  

//enable versioning option
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.P3-Prod-FE-Bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  
}