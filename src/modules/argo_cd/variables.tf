variable "namespace" {
  type    = string
  default = "argocd"
}
variable "chart_version" {
  type    = string
  default = "7.1.3"
}
variable "repo_url" {
  type    = string
  default = ""
}
variable "chart_branch" {
  type    = string
  default = "main"
}
