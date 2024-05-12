# From-Code-to-Cloud : 
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


## Planning the workflow


![image](https://github.com/Suraj01Dev/From-Code-to-Cloud/assets/120789150/667516c9-4ce3-40d2-9793-94fb5aad81b1)


The main motivation of the project is to deploy a Python API into an AWS EC2 instance with high availability. For redundancy, a Virtual Private Cloud (VPC) will be created with two public subnets in two availability zones: eu-west-1a and eu-west-1b.

**Visual Representation**
![image](https://github.com/Suraj01Dev/From-Code-to-Cloud/assets/120789150/b6a3b843-5e21-4b8f-ba7e-8cce07bbd1f9)

This diagram illustrates the planned VPC setup with two public subnets spread across different availability zones to ensure high availability and fault tolerance.





















