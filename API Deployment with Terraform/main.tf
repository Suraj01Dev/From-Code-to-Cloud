module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  eu_availability_zone = var.eu_availability_zone
}

module "security_group" {
  source                     = "./security-groups"
  ec2_sg_name                = "SG for EC2 to enable SSH(22) and HTTP(80)"
  vpc_id                     = module.networking.dev_project_api_vpc_id
  ec2_sg_name_for_python_api = "SG for EC2 for enabling port 5000"
}


module "ec2" {
  source                     = "./ec2-instance"
  ami_id                     = var.ec2_ami_id
  instance_type              = "t2.micro"
  tag_name                   = "Ubuntu Linux EC2"
  public_key                 = var.public_key
  subnet_id                  = tolist(module.networking.dev_project_api_public_subnets)[0]
  sg_enable_ssh_https        = module.security_group.sg_ec2_sg_ssh_http_id
  ec2_sg_name_for_python_api = module.security_group.sg_ec2_for_python_api
  enable_public_ip_address   = true
  user_data_install_apache   = templatefile("./template/deploy_stock_screener_api.sh", {})
}
