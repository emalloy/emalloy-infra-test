module "aws" {
  source                   = "../modules/aws"
  region                   = "eu-central-1"
}


module "vpc" {
  source                  = "../modules/aws/vpc"
//  ec2_security_group      = "${module.vpc.ec2_sg_id}"
  region                   = "eu-central-1"
//  vpc_id                  = "${module.vpc.vpc_id}"
//  aws_key_name            = "${module.vpc.ec2_keypair}"
//  dependency_id           = ""
}



module "ec2" {
  source                  = "../modules/ec2"
  security_group          = "${module.vpc.ec2_sg_id}"
  ubuntu_ami              = "${var.ubuntu_ami}"
  aws_key_name            = "${module.vpc.ec2_keypair}"
  region                  = "eu-central-1"
  subnets                 = "${module.vpc.ec2_subnet_id}"
//  dependency_id           = "${module.vpc.dependency_id}"
}