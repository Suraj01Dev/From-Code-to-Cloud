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
        Name = var.vpc_name
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

