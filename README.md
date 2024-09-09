# AWS-HA-Secured-3-Tier
implement project in AWS console and HCL terraform 

**Situation**
You are tasked with creating a foundational multi-tier architecture in AWS, which includes a Web Tier, Application Tier, and Database Tier. The goal is to build each tier incrementally, ensuring each layer functions correctly before moving on to the next.

**Objective**
1. Web Tier:
Create a public subnet with a minimum of 2 EC2 instances in an Auto Scaling Group.
Configure a Security Group to allow inbound traffic from the internet.
Deploy a static web page on the EC2 instances.
2. Application Tier:

Create private subnets with a minimum of 2 EC2 instances in an Auto Scaling Group.
Configure a Security Group to allow inbound traffic from the Web Server Security Group.
3. Database Tier:

Deploy a MySQL RDS instance in private subnets.
Configure a Security Group to allow inbound MySQL traffic from the Application Server Security Group.
