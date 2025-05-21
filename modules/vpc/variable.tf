variable "vpc_cidr" {
  description = "CIDR block for the vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_a_cidr" {
  description = "CIDR block for subnet a"
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  description = "CIDR block for subnet b"
  type = string
  default = "10.0.2.0/24"
}

variable "subnet_c_cidr" {
  description = "CIDR block for subnet c"
  type = string
  default = "10.0.3.0/24"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}