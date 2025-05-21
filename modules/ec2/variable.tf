variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type = string
  default = "ami-0f9de6e2d2f067fca"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type  = string
  default = "t2.micro"
}

variable "subnet_ids" {
  description = "subnet ids"
  type = map(string)
}

variable "key_name" {
  description = "Key pair name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type = string
}

variable "target_group_a_arn" {
  description = "Target group ARN for instance A."
  type = string
}

variable "target_group_b_arn" {
  description = "Target group ARN for instance B."
  type = string
}

variable "target_group_c_arn" {
  description = "Target group ARN for instance C."
  type = string
}