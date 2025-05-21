module "vpc" {
  source = "./modules/vpc"
  region = "us-east-1"
}


module "alb" {
  source = "./modules/alb"
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"
  subnet_ids = module.vpc.subnet_ids
  key_name = "hcl"
  vpc_id = module.vpc.vpc_id
  target_group_a_arn = module.alb.target_group_a_arn
  target_group_b_arn = module.alb.target_group_b_arn
  target_group_c_arn = module.alb.target_group_c_arn
}
