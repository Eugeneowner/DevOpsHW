variable "owner" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "az1" {
  type = string
}
variable "max_spot_price" {
  type        = string
  description = "Maximum price to pay per hour for spot instances"
  default     = "0.1052"
}