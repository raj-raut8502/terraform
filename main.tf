terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "bucket-9975079507"
}
