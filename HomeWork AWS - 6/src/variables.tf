variable "instance_type" {}
variable "allowed_ports" {
  type = list(number)
}
variable "ssh_key_pair_name" {}
variable "instance_count" {
  type    = number
  default = 1
}
