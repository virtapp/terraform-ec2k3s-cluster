![image](https://github.com/user-attachments/assets/5989d539-a9c1-4891-a387-4c8a5e008054)

## Terraform Provisioner | K3S Model  🚀🚀🚀



🎯  Key Features
```
✅ Launch EC2 Instances
✅ Install K3S Binary ( Kubernetes )
✅ Prepare Cluster Configuration
✅ Deploy Helm Charts 
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

