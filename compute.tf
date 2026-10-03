# Fetch the latest official Amazon Linux 2023 AMI dynamically
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  user_data = <<-EOF
              #!/bin/bash
              # 1. Create custom user & assign sudo privileges
              useradd -m -s /bin/bash ${var.custom_username}
              echo "${var.custom_username}:${var.custom_password}" | chpasswd
              usermod -aG wheel ${var.custom_username}

              # 2. Enable Password Authentication in SSH config
              sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              echo "PasswordAuthentication yes" > /etc/ssh/sshd_config.d/60-password-auth.conf

              # 3. Restart SSH daemon to apply changes
              systemctl restart sshd
              EOF

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}