module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = "10.1.0.0/16"

  public_subnet_1_cidr  = "10.1.1.0/24"
  public_subnet_2_cidr  = "10.1.2.0/24"

  private_subnet_1_cidr = "10.1.3.0/24"
  private_subnet_2_cidr = "10.1.4.0/24"
}
module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
}
module "ec2" {
  source = "./modules/ec2"

  subnet_id         = module.vpc.public_subnet_1_id
  security_group_id = module.security.security_group_id
}
module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source = "./modules/eks"

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
}

