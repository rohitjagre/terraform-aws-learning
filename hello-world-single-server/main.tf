provider "aws" {
  region  = "ap-south-1"
  version = 2.54
}

variable "server_port" {
  description = "the port server will use for http requests"
  type        = number
  default     = 8080
}

resource "aws_instance" "instance" {
  ami                    = "ami-0620d12a9cf777c87"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example_sg.id]

  user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello, World" > index.html
                    nohup busybox httpd -f -p "${var.server_port}" &
                EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "example_sg" {
  name = "terraform-example-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.instance.public_ip
  description = "public ip of the web server"
}
