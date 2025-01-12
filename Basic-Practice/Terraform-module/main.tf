module "vpc_modules" {
  source         = "./modules/aws_vpc"
  for_each       = var.vpc_config
  vpc_cidr_block = each.value.vpc_cidr_block
  tags           = each.value.tags
}


module "aws_subnet" {
  source            = "./modules/aws_subnet"
  for_each          = var.subnet_config
  vpc_id            = module.vpc_modules[each.value.vpc_name].vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value.tags
}

module "igw_module" {
 source = "./modules/aws_igw"
 for_each = var.igw_config
 vpc_id = module.vpc_modules[each.value.vpc_name].vpc_id
 tags = each.value.tags
}

module "NatGW_module" {
  source = "./modules/aws_natGW"
  for_each = var.nat_GW_config
  elasticIP_id = module.elastic_IP_module[each.value.eip_name].elastic_IP_id
  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id
  tags = each.value.tags
}

module "elastic_IP_module" {
  source = "./modules/aws_elastic_IP"
  for_each = var.elastic_IP_config
  tags = each.value.tags
}

module "route_table_module" {
  source = "./modules/aws_route_table"
  for_each = var.route_table_config
  vpc_id = module.vpc_modules[each.value.vpc_name].vpc_id
  igw_id = each.value.private == 0 ? module.igw_module[each.value.gatewat_name].igw_id : module.nat_GW_config[each.value.gatewat_name].nat_GW_id
  tags = each.value.tags
}

module "route_table_association" {
  source = "./modules/aws_rt_association"
  for_each = var.aws_rt_association_config
  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id
  route_table_id = module.route_table_module[each.value.route_table_name].route_table_id
}