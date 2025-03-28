# Step to use
- Step 1: using 
  ```bash
  chmod +x script-to-create-tfvars.sh
  bash ./script-to-create-tfvars.sh
  ```
- Step 2: Fill in all fields in terraform.tfvars

- Step 3: init terraform provider
```bash
terraform init
```
- Step 4: terraform apply
```bash
terraform apply --auto-approve
```
