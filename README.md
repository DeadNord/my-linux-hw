# Lesson-7: Terraform + EKS + Helm

# Lesson-5 — команды запуска

```bash
aws s3api create-bucket \
    --bucket hw-7-terraform \
    --region eu-central-1 \
    --create-bucket-configuration LocationConstraint=eu-central-1

aws dynamodb create-table \
    --table-name hw-7-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema            AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region eu-central-1

cd ./src
# terraform init
terraform init -migrate-state
terraform init -reconfigure

terraform import module.s3_backend.aws_s3_bucket.this hw-7-terraform
terraform import module.s3_backend.aws_dynamodb_table.this hw-7-terraform-locks

terraform state list | grep module.s3_backend

terraform plan
terraform apply

terraform destroy

cd ../

bash purge-and-delete-s3.sh hw-7-terraform eu-central-1
```
