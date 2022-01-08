data "terraform_remote_state" "main_vpc" {
  backend = "s3"
  
  config = {
    bucket = "luai-terraform-state"
    region = "ap-southeast-1"
    key = "main_vpc.tfstate"
   }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  
  config = {
    bucket = "luai-terraform-state"
    region = "ap-southeast-1"
    key = "sg.tfstate"
   }
}