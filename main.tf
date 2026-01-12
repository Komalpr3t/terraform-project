provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  tags = {
    Name        = "terraform-${var.env}"
    Environment = var.env
  }
}
