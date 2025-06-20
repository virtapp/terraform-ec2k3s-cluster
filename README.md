

## Terraform Provisioner | K3S Model  🚀🚀🚀



🎯  Key Features
```
✅ Launch EC2 Instances
✅ Install Dependencies
✅ Prepare Kubernetes Cluster
✅ Post-Configuration
```

🚀 
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

🧩 Config 

```
scp -i ~/.ssh/<your pem file> <your pem file> ec2-user@<terraform instance public ip>:/home/ec2-user
chmod 400 <your pem file>
```

