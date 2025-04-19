variable "ami" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list(string)
}
variable "allowed_ports" {
  type = list(number)
}
variable "vpc_id" {}
variable "ssh_key_pair_name" {}
variable "instance_count" {
  type    = number
  default = 1
}
