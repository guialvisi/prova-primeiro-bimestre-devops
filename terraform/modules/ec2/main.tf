resource "aws_instance" "api" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  associate_public_ip_address = true

  iam_instance_profile = "LabInstanceProfile"

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y docker

    systemctl enable docker
    systemctl start docker

    mkdir -p /opt/technova

    cat > /opt/technova/.env <<EOT
    DB_HOST=${var.db_host}
    DB_PORT=5432
    DB_NAME=${var.db_name}
    DB_USER=${var.db_username}
    DB_PASSWORD=${var.db_password}
    PORT=3000
    EOT
  EOF

  tags = {
    Name        = "${var.project_name}-api"
    Project     = "TechNova-Reservas"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
