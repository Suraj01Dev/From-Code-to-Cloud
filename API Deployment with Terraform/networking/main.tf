variable "vpc_cidr"{}
variable "vpc_name"{}
variable "cidr_public_subnet"{}
variable "eu_availability_zone"{}

output "dev_project_api_vpc_id"{
  value=aws_vpc.api-project-vpc.id
}


output "dev_project_api_public_subnets" {
  value = aws_subnet.api-project-subnet.*.id
}


resource "aws_vpc" "api-project-vpc"{
    cidr_block=var.vpc_cidr
    tags={
        Name = var.vpc_namevariable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_enable_ssh_https" {}
variable "enable_public_ip_address" {}
variable "user_data_install_apache" {}
variable "ec2_sg_name_for_python_api" {}



output "dev_proj_1_ec2_instance_id" {
  value = aws_instance.dev_project_api_ec2.id
}

resource "aws_instance" "dev_project_api_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "aws_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_apache

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "dev_proj_1_public_key" {
  key_name   = "aws_key"
  public_key = var.public_key
}


    }
}


resource "aws_subnet" "api-project-subnet" {
  count=length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.api-project-vpc.id
  cidr_block = element(var.cidr_public_subnet, count.index )
  availability_zone = element(var.eu_availability_zone, count.index)
}


resource "aws_internet_gateway" "api-project-ig" {
  vpc_id = aws_vpc.api-project-vpc.id
}


resource "aws_route_table" "api-project-rt" {
  vpc_id = aws_vpc.api-project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.api-project-ig.id
  }
}


resource "aws_route_table_association" "api-project-rt-a" {
  count=length(aws_subnet.api-project-subnet)
  subnet_id      = aws_subnet.api-project-subnet[count.index].id
  route_table_id = aws_route_table.api-project-rt.id
}
