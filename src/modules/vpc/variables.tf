variable "vpc_cidr_block" {
  description = "CIDR VPC"
  type        = string
}

variable "public_subnets" {
  description = "CIDR блоки public подсетей"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR блоки private подсетей"
  type        = list(string)
}

variable "availability_zones" {
  description = "AZs (одна на каждую подсеть)"
  type        = list(string)
}

variable "vpc_name" {
  description = "Base name prefix"
  type        = string
}

variable "nat_eip_allocation_id" {
  description = <<-EOT
  Существующий Allocation ID EIP для NAT Gateway.
  Оставьте пусто, чтобы модуль создал EIP сам.
  EOT
  type        = string
  default     = ""
}
