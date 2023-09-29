module "Augstine-server" {
    source = "./modules/ec2"
    subnetId = module.network.subnetID
    sg = module.Augustine-sg.sg
}

module "network" {
    source = "./modules/network"
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
  






