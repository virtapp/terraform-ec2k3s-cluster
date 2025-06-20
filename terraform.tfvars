region         = "us-east-1"
# Ubuntu 22.04 LTS AMI (replace with a valid ID for your region)
ami_id         = "ami-0fc5d935ebf8bc3bc"
# Instance type suitable for K3s
instance_type  = "t3.medium"
# Number of master (server) nodes
master_count   = 3
worker_count   = 2
