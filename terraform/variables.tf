variable "aws_region" { type = string, default = "us-east-1" }
variable "cluster_name" { type = string, default = "default" }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_group_desired_capacity" { type = number, default = 2 }
variable "node_instance_type" { type = string, default = "t3.medium" }
variable "key_name" { type = string, default = "your-keypair" }
