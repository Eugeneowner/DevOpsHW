[web]
%{ for ip in instance_ips ~}
${ip} ansible_user=ec2-user ansible_ssh_private_key_file=./private.key
%{ endfor ~}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
