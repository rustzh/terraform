locals {
  bastion_tags = {
    Name        = "cccr2-ec2-bastion"
    Project     = "cccr2"
    Environment = "dev"
    Role        = "bastion"
  }
}