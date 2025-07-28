resource "helm_release" "kube-prometheus-stack" {
  name             = var.prometheus_name
  namespace        = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "75.10.0"
  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
