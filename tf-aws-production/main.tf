# 모듈 선언
module "cccr2_vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.64.0/20"
  vpc_name    = "cccr2-vpc"
  az          = "ap-northeast-2a"
}