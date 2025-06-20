region         = "us-east-1"
ami_id         = "mi-0345dd2cef523536e"
instance_type  = "t3.medium"
master_count   = 3
worker_count   = 2
ssh_allowed_cidr = "0.0.0.0/0" # Replace with your IP
security_group_name = "k3s-sg"
security_group_description = "K3s cluster SG"
