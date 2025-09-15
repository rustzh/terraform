output "web01_pub_ip" {
  value = aws_instance.pub_web01.public_ip
}

output "web02_pub_ip" {
  value = aws_instance.pub_web02.public_ip
}

output "db01_priv_ip" {
  value = aws_instance.database01.private_ip
}

output "elb_dns_addr" {
  value = aws_elb.cloud_clb.dns_name
}