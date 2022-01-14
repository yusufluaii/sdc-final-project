output "vpc_id" {
  value = module.main_vpc.vpc_id
}

output "public_subnets_id" {
  value = module.main_vpc.public_subnets
}


output "vpc_cidr_blocks" {
  value = module.main_vpc.vpc_cidr_block
}


output "public_subnet_cidr_blocks" {
  value = module.main_vpc.public_subnets_cidr_blocks
}


output "database_subnets_id"{
  value = module.main_vpc.database_subnets
}

output "main_vpc_igw" {
  value = module.main_vpc.igw_id
}



output "main_vpc_public_rtb" {
  value = module.main_vpc.public_route_table_ids
}

output "main_vpc_rtb_id" {
  value = module.main_vpc.vpc_main_route_table_id
}

