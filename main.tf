module "ubuntu" {
  source                 = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git"
  ami                    = data.aws_ami.ubuntu-linux-2025.id
  key_name               = module.aws_key.get_key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security_group.security_id
  region                 = var.region
  tags = {
    "Name" = "windows-${local.name}-${module.unique_name.unique}"
  }
  user_data = file("${path.module}/scripts/ubuntu.sh")
}

module "amazon-linux" {
  source                 = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git"
  ami                    = data.aws_ami.amazon-linux-2025.id
  key_name               = module.aws_key.get_key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security_group.security_id
  region                 = var.region
  tags = {
    "Name" = "windows-${local.name}-${module.unique_name.unique}"
  }
  user_data = file("${path.module}/scripts/amazon-linux.sh")
}

resource "terraform_data" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.aws_key.private_key}' > ./'${module.unique_name.unique}'.pem
        chmod 400 ./'${module.unique_name.unique}'.pem
      EOT
  }
}

module "aws_key" {
  source   = "git::https://github.com/devops-terraform-aws/ssh-key-module.git?ref=v1.0.0"
  key_name = module.unique_name.unique
}

module "unique_name" {
  source = "git::https://github.com/devops-terraform-aws/random-module.git?ref=v1.0.0"
}

module "security_group" {
  source = "git::https://github.com/devops-terraform-aws/security-group-module.git"
  name   = "${local.name}-${module.unique_name.unique}"
  tags = {
    "Name" = "sg-${local.name}-${module.unique_name.unique}"
  }
  ingress_rules = [
    {
      description = "Allows SSH traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      description = "Allow all traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}