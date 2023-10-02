/*

module "Augstine-server" {
    source = "./modules/ec2"
    subnetId = module.network.subnetID
    sg = module.Augustine-sg.sg
}

module "network" {
    source = "./modules/network"
    name = "Augustine"
}

module "Augustine-sg" {
    source = "./modules/security"
    vpcID = module.network.vpcID
    sgName = "Augustine-sg"
}
module "joshua" {
    source = "./modules/security"
    vpcID = module.network.vpcID
    sgName = "Joshua"
  
}

module "Augustine-vpc" {
  source = "./modules/network"
  vpc-cidr = "10.10.0.0/16"
  name = "Augustine"
}

*/

module "test-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr = "10.20.0.0/16"
  name = "test-vpc"
  azs  =  ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.20.10.0/24"]
  private_subnets = ["10.20.10.0/24"]
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "my-augustine-s3" {
    source = "terraform-aws-modules/s3-bucket/aws"
    bucket = "my-augustine-s3-bucket"
    tags = {
        env = "prod"
        owner = "Augustine"  
    }
} 
 
  
module "git-module-vpc" {
  source = "github.com/Likine92/Augustine-terraform-projects/modules/network"
  vpc-cidr = "10.30.0.0/16"
  name = "Augustine-oct-vpc"
  avZone = "us-east-1c"
}

module "git-module-sg" {
    source = "github.com/Likine92/Augustine-terraform-projects/modules/security"
    vpcID = module.git-module-vpc.vpcID
    sgName = "John-sg"
    
}






