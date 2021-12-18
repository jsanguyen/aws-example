# aws-example

Example of Terraform usage to create and provision roles and users inside of AWS.


1. Pull repo, ```terraform init``` in project, and add your AWS credentials inside the ```terraform.tfvars``` file. 


2. Run the terraform script to deploy examples into your AWS ecosystem. 

```
terraform apply
```

3. Destroy terraform proccess to rollback changes inside of AWS. 

```
terraform destroy
```
