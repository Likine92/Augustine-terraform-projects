data "aws_ami" "amazn-linux2" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}