variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04
}

variable "instance_type" {
  default = "t3.medium"
}

variable "master_count" {
  default = 3
}

variable "worker_count" {
  default = 2
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to access port 22"
  default     = "0.0.0.0/0"
}

variable "security_group_name" {
  description = "Name for the K3s security group"
  default     = "k3s-cluster-sg"
}

variable "security_group_description" {
  description = "Description for the K3s security group"
  default     = "Allow traffic for K3s cluster nodes"
}
