# Lesson-8-9 CI/CD

This project demonstrates a simple CI/CD chain with **Terraform**, **Jenkins** and **Argo CD**.

```bash
aws s3api create-bucket \
    --bucket hw-8-9-terraform \
    --region eu-central-1 \
    --create-bucket-configuration LocationConstraint=eu-central-1

aws dynamodb create-table \
    --table-name hw-8-9-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema            AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region eu-central-1
```

## Terraform usage

```bash
cd ./src
terraform init
terraform validate
terraform plan
terraform apply
```

Infrastructure includes ECR, EKS cluster, Jenkins and Argo CD installed via Helm charts.

## Jenkins pipeline

`Jenkinsfile` contains a pipeline which:

1. Builds a Docker image for the Django application.
2. Pushes the image to ECR.
3. Updates the image tag in the Helm chart and pushes changes to `main`.

After applying Terraform open Jenkins (service `jenkins` in namespace `jenkins`) and run the pipeline.

## Argo CD

Argo CD watches the Helm chart and automatically deploys new revisions into the cluster. Use port-forward to access the UI:

```bash
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

Login with the password from:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

Once the Jenkins pipeline updates the chart, Argo CD will sync the application.
