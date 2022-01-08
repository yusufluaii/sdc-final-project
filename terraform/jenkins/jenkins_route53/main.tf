data "aws_route53_zone" "yusufluai" {
  name         = "yusufluai.my.id"
  private_zone = false
}




module "jenkins_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = data.aws_route53_zone.yusufluai.name

  records = [
    {
      name    = "jenkins"
      type    = "A"
      alias   = {
        name    = data.terraform_remote_state.sosialmedia_remote_alb.outputs.dns_name
        zone_id = data.terraform_remote_state.sosialmedia_remote_alb.outputs.zone_id
      }
    }
  ]
}