module "project" {
  source             = "./modules/nginx_instance"
  project_name       = local.full_prj_name
  list_of_open_ports = var.list_of_open_ports
  instance_ami       = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  vpc_id             = data.aws_vpc.default.id
  subnet_id          = data.aws_subnets.default_vpc_subnets.ids[0]
}