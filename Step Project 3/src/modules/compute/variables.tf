variable "worker_type" {
  type        = string
  description = "Тип Jenkins Worker: spot или on-demand"
  default     = "spot"
  validation {
    condition     = contains(["spot", "on-demand"], var.worker_type)
    error_message = "worker_type must be either 'spot' or 'on-demand'."
  }
}
variable "public_ssh_key" {
  type = string
}

variable "owner" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "allowed_ports" {
  type = list(number)
}