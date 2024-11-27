module "prod_compute_1" {
  source      = "../modules/compute"
  environment = module.prod_vpc_1.environment
  amis = {
    us-east-1 = "ami-04505e74c0741db8d" # ubuntu 20.04 LTS
    us-east-2 = "ami-04505e74c0741db90" # ubuntu 20.04 LTS
  }
  aws_region           = var.aws_region
  instance_type        = "t2.micro"
  key_name             = "newer"
  iam_instance_profile = module.prod_iam_1.instprofile
  public_subnets       = module.prod_vpc_1.public_subnets_id
  private_subnets      = module.prod_vpc_1.private_subnets_id
  sg_id                = module.prod_sg_1.sg_id
  vpc_name             = module.prod_vpc_1.vpc_name
  elb_listener         = module.prod_elb_1.elb_listner
  elb_listener_public  = module.prod_elb_1_public.elb_listner
}

module "prod_elb_1" {
  source          = "../modules/elb"
  environment     = module.prod_vpc_1.environment
  nlbname         = "prod-nlb"
  subnets         = module.prod_vpc_1.public_subnets_id
  tgname          = "prod-nlb-tg"
  vpc_id          = module.prod_vpc_1.vpc_id
  private_servers = module.prod_compute_1.private_servers
}

module "prod_elb_1_public" {
  source          = "../modules/elb"
  environment     = module.prod_vpc_1.environment
  nlbname         = "prod-nlb-public"
  subnets         = module.prod_vpc_1.public_subnets_id
  tgname          = "prod-nlb-tg-public"
  vpc_id          = module.prod_vpc_1.vpc_id
  private_servers = module.prod_compute_1.public_servers
}

module "prod_iam_1" {
  source              = "../modules/iam"
  environment         = module.prod_vpc_1.environment
  rolename            = "HarryRole"
  instanceprofilename = "Harryprofile"
}
