# Lesson-7 — команды запуска

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

terraform validate
terraform plan
terraform apply

terraform output
terraform output -raw ecr_repository_url
terraform output -raw cluster_name

ECR_URL=$(terraform output -raw ecr_repository_url)
EKS_CLUSTER=$(terraform output -raw cluster_name)
REGION=eu-central-1

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region "${REGION}" \
  | docker login --username AWS --password-stdin "${ECR_URL}"
docker build -t lesson-7-django:latest .
docker tag lesson-7-django:latest "${ECR_URL}:latest"
docker push "${ECR_URL}:latest"

terraform destroy

cd ../

bash purge-and-delete-s3.sh hw-7-terraform eu-central-1
```
