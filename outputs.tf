output "ubuntu-ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i '${module.unique_name.unique}.pem' ubuntu@${module.ubuntu.public_ip_address}"
}

output "jenkins-url" {
  value = "http://${module.ubuntu.public_ip_address}:8080"
}

output "amazon-linux-ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i '${module.unique_name.unique}.pem' ec2-user@${module.amazon-linux.public_ip_address}"
}