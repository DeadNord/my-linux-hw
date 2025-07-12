# Lesson-7: Terraform + EKS + Helm

## Передумови

* AWS аккаунт із IAM користувачем, що має права EKS/ECR/VPC/S3/DynamoDB.
* Docker та AWS CLI.
* Kubectl v1.30+ і Helm v3.

## Кроки

1. **Ініціалізуйте Terraform**

   ```bash
   cd lesson-7
   terraform init
