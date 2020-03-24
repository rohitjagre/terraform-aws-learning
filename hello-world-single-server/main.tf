provider "aws" {
  region  = "ap-south-1"
  version = 2.54
}

resource "aws_instance" "example" {
  ami           = "ami-0620d12a9cf777c87"
  instance_type = "t2.micro"

  user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello, World" > index.html
                    nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
    Name = "terraform-example"
  }
}
