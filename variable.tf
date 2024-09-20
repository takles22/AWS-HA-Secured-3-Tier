variable "vpc_name" {
  type    = string
  default = "vpc_HA_3-Tire"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Define the number of private subnets
variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 4
}

variable "public_subnet_count" {
  description = "Number of Public subnets"
  type        = number
  default     = 2
}

# List of availability zones
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "instance_type" {
  description = "instance type for web and app"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "name of ssh key "
  type = string
   default = "memocd"
}

variable "key_path" {
  description = "path of key pair"
  type = string
  default = "~/.ssh/memo.pub"
}