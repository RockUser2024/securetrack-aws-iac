resource "aws_instance" "web_server" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = {
    Name = "securetrack-terraform-ec2"
  }
}


