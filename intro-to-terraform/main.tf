provider "aws" {
  region  = "ap-south-1"
  version = 2.54
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
