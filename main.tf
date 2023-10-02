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
  






