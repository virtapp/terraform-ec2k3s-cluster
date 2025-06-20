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
