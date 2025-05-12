variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "az1" {
  default = "eu-central-1a"
}

variable "owner" {
  type        = string
  description = "Owner tag for all resources"
}

variable "public_ssh_key" {
  type        = string
  description = "Public key to add to EC2 instances"
}

variable "private_ssh_key" {
  type        = string
  description = "Name of the private key file to be written"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "allowed_ports" {
  type        = list(number)
  description = "List of allowed ports in security group"
}

variable "worker_type" {
  type        = string
  description = "Тип Jenkins Worker: spot или on-demand"
  default     = "spot"
}