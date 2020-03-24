provider "aws" {
  region  = "ap-south-1"
  version = 2.54
}

resource "aws_instance" "example" {
  ami                    = "ami-0620d12a9cf777c87"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example_sg.id]

  user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello, World" > index.html
                    nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "example_sg" {
  name = "terraform-example-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
