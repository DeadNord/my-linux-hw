# Steps

!!! Make sure you have installed `Terraform` and `Helm` on your system.

## Terraform

Ініціалізація Terraform:

```bash
terraform init
```

Перевірка змін:

```bash
terraform plan
```

Застосування змін:

```bash
terraform apply --auto-approve
```

Завантажити django image на новостворений ECR-репозиторій:

```bash
REPO_URL=$(terraform output -raw ecr_repository_url)
export AWS_ACCOUNT_ID=${REPO_URL%%.*}
export AWS_REGION=$(echo "$REPO_URL" | cut -d. -f4)
export ECR_REPOSITORY=${REPO_URL##*/}

aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker build -t django-hw-9:latest ./app
docker tag django-hw-9:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:latest
```

where `django-hw-9:latest` your django image name that already exists in your local machine.

Replace $AWS_ACCOUNT_ID, $AWS_REGION, and $ECR_REPOSITORY with your own values.

## Kubernetes

```bash
aws eks update-kubeconfig --region eu-central-1 --name eks-cluster-alex
kubectl get nodes
kubectl cluster-info
```

## Helm

Застосування Helm:

```bash
cd charts/django-app
helm install my-django .
```

where `my-django` is your helm chart name.

## Argo CD

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo

kubectl -n argocd port-forward svc/argo-cd-argocd-server 8080:443
kubectl -n argocd get svc
```

# Видалення ресурсів:

Kubernetes (PODs, Services, Deployments etc.)

```bash
helm uninstall my-django
```

where `my-django` is your helm chart name.

Terraform (EKS, VPC, ECR etc.)

```bash
terraform destroy
```

# Додаткова інформація:

Якщо ви хочете оновити helm chart:

```bash
helm upgrade my-django .
```

Якщо ви хочете оновити terraform:

```bash
terraform init -upgrade
terraform plan
terraform apply
```

# Опис модулів terraform

## s3-backend

Модуль для створення S3-бакета для збереження стейтів.
В модулі створюється S3-бакет, налаштовується версіонування та контроль власності.
Також створюється DynamoDB-таблиця для блокування стейтів.

## vpc

Модуль для створення VPC.
В модулі встановлена VPC, публічні підмережі, приватні підмережі та зони доступності.
Також створюється NAT Gateway, Internet Gateway та таблиці роутів для доступу до інтернету.

## ecr

Модуль для створення ECR-репозиторію.
В модулі створюється репозиторій ECR, налаштовується автоматичне сканування security-вразливостей під час push.

## eks

Модуль для створення EKS-кластера.
В модулі створюється EKS-кластер, налаштовується автоматичне сканування security-вразливостей під час push.
