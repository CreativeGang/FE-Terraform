
//terraform backends remote state with Dynamodb
terraform {
  backend "s3" {
    encrypt = true
    bucket = "jrp3-terraform-state-file"
    region = "us-west-1"
    key = "./Prod/FE-terraform.tfstate"
    profile = "default"
    dynamodb_table = "terraform-state-lock-dynamodb"
    //workspace_key_prefix = "goexperts-fe"
  }
}

provider "aws" {
  region = "us-west-1"
  profile = "default"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}

module "web_hosting_S3" {
  source = "./modules/AWS-FrontEnd"
}
