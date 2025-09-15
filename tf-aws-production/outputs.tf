output "instance_public_ip_bastion" {
  description = "Public ip of bastion instance"
  value       = aws_instance.cccr2_bastion.public_ip
}

output "instance_private_ip_bastion" {
  description = "Private ip of bastion instance"
  value       = aws_instance.cccr2_bastion.private_ip
}

output "instance_private_ip_web01" {
  description = "Private ip of web01 instance"
  value       = aws_instance.cccr2_web01.private_ip
}

output "instance_private_ip_web02" {
  description = "Private ip of web02 instance"
  value       = aws_instance.cccr2_web02.private_ip
} 