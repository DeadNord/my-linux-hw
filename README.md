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
PRINCIPAL_ARN=$(aws sts get-caller-identity --query Arn --output text)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws ecr get-login-password --region "${REGION}" \
  | docker login --username AWS --password-stdin "${ECR_URL}"
docker build -t lesson-7-django:latest ../app
docker tag lesson-7-django:latest "${ECR_URL}:latest"
docker push "${ECR_URL}:latest"

helm template django-app ./charts/django-app \
  --set image.repository="${ECR_URL}" \
  --set image.tag=latest | less

helm upgrade --install django-app ./charts/django-app \
  --set image.repository="${ECR_URL}" \
  --set image.tag=latest

kubectl get pods
kubectl get hpa

POD=$(kubectl get pods -l app.kubernetes.io/name=django-app -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it "$POD" -- env | grep DJANGO

# helm uninstall django-app || true
# kubectl get svc | grep django || echo "svc удалён"
# aws elb describe-load-balancers --region $REGION --output text | grep -i lesson-7 || true
# aws elbv2 describe-load-balancers --region $REGION --output text | grep -i lesson-7 || true

# terraform destroy -target=module.eks -auto-approve
# aws ec2 describe-instances \
#   --filters "Name=tag:kubernetes.io/cluster/lesson-7-cluster,Values=owned" \
#   --query 'Reservations[].Instances[].InstanceId' \
#   --region $REGION

# aws ec2 describe-nat-gateways \
# --filter Name=vpc-id,Values=$(terraform output -raw vpc_id 2>/dev/null || echo none) \
# --region $REGION \
# --query 'NatGateways[].NatGatewayId'
# aws ec2 delete-nat-gateway --nat-gateway-id nat-XXXXX --region $REGION


# aws ec2 describe-addresses --region $REGION --query 'Addresses[].{Alloc:AllocationId,Assoc:AssociationId,PublicIp:PublicIp}'
# aws ec2 disassociate-address --association-id eipassoc-XXXX --region $REGION
# aws ec2 release-address --allocation-id eipalloc-XXXX --region $REGION

# terraform destroy -target=module.vpc -auto-approve

ECR_REPO=lesson-7-django
aws ecr delete-repository --repository-name $ECR_REPO --force --region $REGION

aws ec2 describe-network-interfaces \
  --region $REGION \
  --filters Name=vpc-id,Values=$VPC_ID \
  --query 'NetworkInterfaces[].{Id:NetworkInterfaceId,Status:Status,Desc:Description,AttachId:Attachment.AttachmentId,Instance:Attachment.InstanceId,Subnet:SubnetId,PrivateIp:PrivateIpAddress}' \
  --output table

terraform destroy

cd ../

bash purge-and-delete-s3.sh hw-7-terraform eu-central-1
```
