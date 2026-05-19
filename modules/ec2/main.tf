resource "aws_instance" "myserver" {
  ami                    = "ami-0d52744d6551d851e"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker
docker run -d -p 80:80 nginx
EOF

  tags = {
    Name = "terraform-server-${terraform.workspace}"
  }
}