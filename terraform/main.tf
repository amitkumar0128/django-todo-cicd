# Security Group
resource "aws_security_group" "todo_sg" {
  name        = "todo_sg"
  description = "Allow SSH and ToDo App ports"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ToDo App"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "todo_sg"
    Project = "Django ToDo App"
  }
}


# EC2 Instance
resource "aws_instance" "todo_app" {
  ami                    = "ami-02d26659fd82cf299"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key_pair.key_name
  security_groups = [aws_security_group.todo_sg.name]
  
  provisioner "remote-exec" {
                inline = [
                        "sudo apt-get update",
                        "sudo apt-get install docker.io -y",
                        "sudo apt-get install docker-compose-v2 -y",
                        "git clone ${var.github_repo_url}",
                        "cd ${var.github_repo_name}",
                        "sudo docker compose up -d",
                ]
                connection {
                        type        = "ssh"
                        user        = "ubuntu"  # or "ec2-user" depending on the AMI
                        private_key = file("${path.module}/${var.key_name}.pem")
                        host        = self.public_ip
                }

        }

  tags = {
    Name    = "ToDo-EC2"
    Project = "Django ToDo App"
  }


}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_name 
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/${var.key_name}.pem"
  file_permission = "0600"
}

# Output ToDo App URL
output "todo_app_ip" {
  description = "ToDo App is running at http://<ip>"
  value       = "ToDo App is running at http://${aws_instance.todo_app.public_ip}"
}