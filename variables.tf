variable "instanceType" {
    default = "t2.micro" 
    }
variable "key-pair" {
    default = "terraform-key" 
    }
variable "vpc-cidr" {
    default = "10.0.0.0/16" 
    }
variable "avZone" {
     default = "us-east-1a"
     }
variable "region" {
    default = "us-east-1"
    }
variable "keyName" {
    default = "~/.ssh/id_rsa.pub"
  
}


