provider "aws" {
  region  = "ap-south-1"
  version = "~> 2.54"
}

resource "aws_instance" "example" {
  ami           = "ami-0620d12a9cf777c87"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
