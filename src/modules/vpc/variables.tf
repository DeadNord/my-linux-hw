variable "vpc_cidr_block" { type = string }
variable "public_subnets" { type = list(string) }     # ровно 3 CIDR
variable "private_subnets" { type = list(string) }    # ровно 3 CIDR
variable "availability_zones" { type = list(string) } # ровно 3 AZ
variable "vpc_name" { type = string }
