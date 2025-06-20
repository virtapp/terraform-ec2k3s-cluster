
variable "region" {
  default = "us-west-2"
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
  default = "0.0.0.0/0"
}

variable "security_group_name" {
  default = "k3s-cluster-sg"
}

variable "security_group_description" {
  default = "K3s cluster security group"
}

variable "ssh_public_key_path" {
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  default = "/home/ubuntu/.ssh/id_rsa"
}
