data "terraform_remote_state" "main_vpc" {
  backend = "s3"
  config = {
    bucket = "luai-terraform-state"
    region = "ap-southeast-1"
    key = "main_vpc.tfstate"
   }
}



module "main_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "main-sg"
  description = "Security group for publicly open"
  vpc_id      = data.terraform_remote_state.main_vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp","http-8080-tcp"]
}


module "db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "db-sg"
  description = "Security group for publicly open"
  vpc_id      = data.terraform_remote_state.main_vpc.outputs.vpc_id

  ingress_cidr_blocks = ["10.0.0.0/16"]
  egress_rules        = ["all-all"]
  ingress_rules       = ["mysql-tcp"]
  depends_on = [
      data.terraform_remote_state.main_vpc
    ]
}
