resource "aws_instance" "Augustine-server" {
  ami                         = "ami-0bb4c991fa89d4b9b"
  instance_type               = var.instanceType #"t2.micro"
  key_name                    = aws_key_pair.test-key.key_name     #"terraform-key"
  subnet_id                   = var.subnetId       //aws_subnet.augustine-subnet.id
  vpc_security_group_ids      = [ var.sg ] //aws_security_group.augustine1-sg.id]
  user_data                   = file("shellscript.sh")
  user_data_replace_on_change = true
  //count = var.tags[count.index]

  tags = {
    Name = "test"
}
}

resource "aws_key_pair" "test-key" {
  key_name = "test-key"
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDuWWD4Mlh68cDyok+O7mjfILzVkdRRq/E4Z8UN/udQJwtoA8jpDx4kr5N0byHDpei4Jrplwm+Eu7Uo4re4g5zf47kRWQ+zp1G5xksP9PstWpcjbQjsdY8vlFaweq5isOoZwgqGafbR7/DEuBFLvlSP4zJrrcJa2qOg0IhQGrRkRlseo0XNSeWt04UUnOWaM8t3HtbO2D2y98nFFjgy9nCleVmIRJ5TBVruzebzobGPMPF1gVXriudGkCQFEn4PM7E09MVE1WdOX2WLX3Np94bUa3g0jzIhx7CQ0C4FOLCbT2wfOXZ674qFbb5oatnRBXYWB6Y/VGCqITziG9VhY7fF"
  public_key = file(var.keyName)
}
