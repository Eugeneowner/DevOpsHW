[jenkins_master]
${public_instance_ip} ansible_user=ec2-user ansible_ssh_private_key_file=../${ssh_key_name}

[jenkins_slave]
${private_instance_ip} ansible_user=ec2-user ansible_ssh_private_key_file=../${ssh_key_name}