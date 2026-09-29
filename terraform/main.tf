data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
}

module "security_group" {
  source = "./modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  project_name = var.project_name

  private_subnet_ids = module.vpc.private_subnet_ids

  rds_security_group_id = module.security_group.rds_security_group_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
module "ec2" {
  source = "./modules/ec2"

  module "ec2" {
  source = "./modules/ec2"

  project_name = var.project_name

  public_subnet_id = module.vpc.public_subnet_ids[0]

  ec2_security_group_id = module.security_group.ec2_security_group_id

  ami_id = data.aws_ami.amazon_linux.id

  db_host     = module.rds.endpoint
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  github_repository = var.github_repository
}
