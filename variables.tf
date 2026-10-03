variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where resources will be provisioned"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the custom VPC"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for the public subnet"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type/size"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key string for EC2 key pair creation"
}

variable "custom_username" {
  type        = string
  default     = "devuser"
  description = "Custom username created via user_data for EC2 password login"
}

variable "custom_password" {
  type        = string
  sensitive   = true
  description = "Password for the custom EC2 user"
}