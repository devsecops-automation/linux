output "ubuntu-ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i '${module.unique_name.unique}.pem' ubuntu@${module.ubuntu.public_ip_address}"
}

output "amazon-linux-ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i '${module.unique_name.unique}.pem' ec2-user@${module.amazon-linux.public_ip_address}"
}