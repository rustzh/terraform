variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "instance_type" {
  description = "AWS EC2 instance type"
  type        = map(string)
  default = {
    "ap-northeast-1" = "t2.micro",
    "ap-northeast-2" = "t3.micro"
  }
}