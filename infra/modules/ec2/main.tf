data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "api" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = "LabInstanceProfile"

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    dnf update -y
    dnf install -y docker git

    systemctl enable docker
    systemctl start docker

    usermod -aG docker ec2-user

    mkdir -p /opt/reservas-api

    cat > /opt/reservas-api/.env <<ENV
    DB_HOST=${var.db_host}
    DB_PORT=5432
    DB_NAME=${var.db_name}
    DB_USER=${var.db_username}
    DB_PASSWORD=${var.db_password}
    PORT=3000
    ENV

    chmod 600 /opt/reservas-api/.env
  EOF

  tags = {
    Name      = "${var.project_name}-api"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}
