resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "eugene-key"
  public_key = var.public_ssh_key
}

resource "aws_security_group" "ec2_sg" {
  name   = "jenkins-sg"
  vpc_id = var.vpc_id

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = var.owner
  }
}

resource "aws_instance" "jenkins_master" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = aws_key_pair.generated.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name  = "Jenkins-Master"
    Owner = var.owner
  }
}

resource "aws_instance" "jenkins_worker" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = aws_key_pair.generated.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  dynamic "instance_market_options" {
    for_each = var.worker_type == "spot" ? [1] : []
    content {
      market_type = "spot"
    }
  }

  tags = {
    Name  = "Jenkins-Worker"
    Owner = var.owner
  }
}