variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "default"
}

variable "vpc_id" {
  description = "Existing VPC ID to use"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs in your VPC"
  type        = list(string)
}

variable "node_group_desired_capacity" {
  type    = number
  default = 2
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  description = "EC2 Keypair name to attach to worker nodes"
  type        = string
  default     = "keypair"
}
