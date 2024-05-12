# Python API Deployment with Terraform on AWS
_Devops Portfolio Project 1_


## Introduction

In the fast-paced world of cloud-native applications, deploying APIs efficiently and securely is paramount. The "From-Code-to-Cloud" project offers a streamlined solution for deploying Python-based APIs on Amazon Web Services (AWS) using Terraform, an infrastructure as code tool.

## Tools and Technologies

To accomplish this task, the project leverages the following tools and technologies:

- **Terraform**: Terraform is an open-source infrastructure as code software tool created by HashiCorp. It allows users to define and provision data center infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL), or optionally JSON.

- **AWS**: Amazon Web Services (AWS) is a subsidiary of Amazon providing on-demand cloud computing platforms and APIs to individuals, companies, and governments, on a metered pay-as-you-go basis.

- **Python**: Python is a high-level, general-purpose programming language known for its simplicity and readability. It is widely used for web development, data science, artificial intelligence, and more.

- **Bash**: Bash, or the Bourne Again Shell, is a Unix shell and command language written by Brian Fox for the GNU Project as a free software replacement for the Bourne shell. It is the default shell on most Linux distributions and macOS.

These tools and technologies work together to automate the deployment process, ensuring scalability, reliability, and maintainability of the deployed API infrastructure on AWS.


## Planning and Building


The project revolves around deployment of a python API in the AWS infrastructure. To accomplish this we will be splitting the project into three sections
  1. Networking
  2. Security
  3. Application Deployment

### Networking
To achieve high availability and fault tolerance, the Networking section will focus on creating a Virtual Private Cloud (VPC) with two public subnets spanning two availability zones: eu-west-1a and eu-west-1b.
#### Visual Representation
![image](https://github.com/Suraj01Dev/From-Code-to-Cloud/assets/120789150/1728235f-ba25-41f1-9382-8d071e6ee19e)

This diagram provides a visual representation of the planned networking infrastructure within the AWS Management Console. It showcases the VPC setup with two public subnets distributed across different availability zones for redundancy and high availability.

Let's go ahead and start building the [networking module](https://github.com/Suraj01Dev/From-Code-to-Cloud/blob/main/API%20Deployment%20with%20Terraform/networking/main.tf) using terraform.

To create a VPC in we need the following resources.
- VPC 
- Subnet
- Internet Gateway
- Route Table
- Route Table Association

#### VPC

```HCL
resource "aws_vpc" "api-project-vpc"{
    cidr_block=var.vpc_cidr
    tags={
        Name = var.vpc_name
    }
}
```
The only argument the aws_vpc takes is the vpc cidr block which is "10.0.0.0/16" and this value is stored in **terraform.tfvars**.

#### Subnet

```HCL
resource "aws_subnet" "api-project-subnet" {
  count=length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.api-project-vpc.id
  cidr_block = element(var.cidr_public_subnet, count.index )
  availability_zone = element(var.eu_availability_zone, count.index)

}
```
The subnet resource takes three arguments vpc_id, cidr_block and availability_zone. The cidr_block takes these values ["10.0.1.0/24", "10.0.2.0/24"]. And the availability zones are **eu-west-1a** and **eu-west-1b**.

### Internet Gateway
The internet gateway is responsible for the subnets having a way to reach the internet.
```HCL
resource "aws_internet_gateway" "api-project-ig" {
  vpc_id = aws_vpc.api-project-vpc.id

}
```

The internet gateway only takes the vpc_id.


### Route Table

```HCL
resource "aws_route_table" "api-project-rt" {
  vpc_id = aws_vpc.api-project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.api-project-ig.id
  }
}

```
The route table creates a route in the VPC with the internet gateway with gateway as "0.0.0.0/0".

### Route Table Association

```HCL
resource "aws_route_table_association" "api-project-rt-a" {
  
  count=length(aws_subnet.api-project-subnet)
  subnet_id      = aws_subnet.api-project-subnet[count.index].id
  route_table_id = aws_route_table.api-project-rt.id
}
```

The route table association links the route table and the subnets.






