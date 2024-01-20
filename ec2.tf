data "aws_ami" "my_ami" {
  most_recent = true
  name_regex  = "^ansible-controller.*"
  owners      = ["816827255260"]

}

resource "aws_instance" "web-1" {

  ami                         = data.aws_ami.my_ami.id
  availability_zone           = "ap-south-2a"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = [aws_security_group.allow-all.id]
  associate_public_ip_address = true

  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "naresh"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo useradd -m ansibleadmin --shell /bin/bash
              sudo mkdir -p /home/ansibleadmin/.ssh
              sudo chown -R ansibleadmin /home/ansibleadmin/
              sudo touch /home/ansibleadmin/.ssh/authorized_keys
              sudo usermod -aG sudo ansibleadmin
              echo 'ansibleadmin ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
              echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSjXgPKbV3ZFOjUVZ3xfzzMj21W5asTZpTB2Jp6qpr03O3OxxcgWaczNBWFLrG+N79Ko+B3cj0vteL4SrHcJtcMZ4Amu4wuJCf/Eb2D/uA6FbUocnwpwq85mzD8JaTFPWIgLK+ArMbWDLAVvjzsPczZyhwmaQI+rtG8GYXoJuR2sjU1bNKgsxmzFCY1BNDAUFUe6SZ/w0BFXqa/MK/N6mwZHnbNOXzXmDHtllK4ioMspZeicRj54iTZxNk6oG4xO7BCDpxQ+lNmGfjwk1FLofzdzJJ5CP/Q9E3ItF5aSGHkxIYcBl4nMrw67e5n3p1r40IcmQvpsCuosvJdSrS4jDDQ9pzLs87R39NoYQKNDKmad8d9G7RJ8vQAu3D9d2cYqA/8aushVSbb6wGCTbOqpRZe4rjWEFVKyWlXdB9yO838Bi2N9WkvsGTNCQMTz5TukQNRZlSAAufuEuBXDEG+paoxeasWJNjHM1glzj57TODfKMh6lpDJYqQowfugDSZNfM= ansibleadmin@ip-10-0-0-6' | sudo tee -a /home/ansibleadmin/.ssh/authorized_keys
              EOF
}

resource "aws_instance" "web-2" {

  ami                         = data.aws_ami.my_ami.id
  availability_zone           = "ap-south-2b"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet2-public.id
  vpc_security_group_ids      = [aws_security_group.allow-all.id]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-2"
    Env        = "Prod"
    Owner      = "naresh"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo useradd -m ansibleadmin --shell /bin/bash
              sudo mkdir -p /home/ansibleadmin/.ssh
              sudo chown -R ansibleadmin /home/ansibleadmin/
              sudo touch /home/ansibleadmin/.ssh/authorized_keys
              sudo usermod -aG sudo ansibleadmin
              echo 'ansibleadmin ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
              echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSjXgPKbV3ZFOjUVZ3xfzzMj21W5asTZpTB2Jp6qpr03O3OxxcgWaczNBWFLrG+N79Ko+B3cj0vteL4SrHcJtcMZ4Amu4wuJCf/Eb2D/uA6FbUocnwpwq85mzD8JaTFPWIgLK+ArMbWDLAVvjzsPczZyhwmaQI+rtG8GYXoJuR2sjU1bNKgsxmzFCY1BNDAUFUe6SZ/w0BFXqa/MK/N6mwZHnbNOXzXmDHtllK4ioMspZeicRj54iTZxNk6oG4xO7BCDpxQ+lNmGfjwk1FLofzdzJJ5CP/Q9E3ItF5aSGHkxIYcBl4nMrw67e5n3p1r40IcmQvpsCuosvJdSrS4jDDQ9pzLs87R39NoYQKNDKmad8d9G7RJ8vQAu3D9d2cYqA/8aushVSbb6wGCTbOqpRZe4rjWEFVKyWlXdB9yO838Bi2N9WkvsGTNCQMTz5TukQNRZlSAAufuEuBXDEG+paoxeasWJNjHM1glzj57TODfKMh6lpDJYqQowfugDSZNfM= ansibleadmin@ip-10-0-0-6' | sudo tee -a /home/ansibleadmin/.ssh/authorized_keys
              EOF
}

resource "aws_instance" "web-3" {

  ami                         = data.aws_ami.my_ami.id
  availability_zone           = "ap-south-2c"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet3-public.id
  vpc_security_group_ids      = [aws_security_group.allow-all.id]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-3"
    Env        = "Prod"
    Owner      = "naresh"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo useradd -m ansibleadmin --shell /bin/bash
              sudo mkdir -p /home/ansibleadmin/.ssh
              sudo chown -R ansibleadmin /home/ansibleadmin/
              sudo touch /home/ansibleadmin/.ssh/authorized_keys
              sudo usermod -aG sudo ansibleadmin
              echo 'ansibleadmin ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
              echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSjXgPKbV3ZFOjUVZ3xfzzMj21W5asTZpTB2Jp6qpr03O3OxxcgWaczNBWFLrG+N79Ko+B3cj0vteL4SrHcJtcMZ4Amu4wuJCf/Eb2D/uA6FbUocnwpwq85mzD8JaTFPWIgLK+ArMbWDLAVvjzsPczZyhwmaQI+rtG8GYXoJuR2sjU1bNKgsxmzFCY1BNDAUFUe6SZ/w0BFXqa/MK/N6mwZHnbNOXzXmDHtllK4ioMspZeicRj54iTZxNk6oG4xO7BCDpxQ+lNmGfjwk1FLofzdzJJ5CP/Q9E3ItF5aSGHkxIYcBl4nMrw67e5n3p1r40IcmQvpsCuosvJdSrS4jDDQ9pzLs87R39NoYQKNDKmad8d9G7RJ8vQAu3D9d2cYqA/8aushVSbb6wGCTbOqpRZe4rjWEFVKyWlXdB9yO838Bi2N9WkvsGTNCQMTz5TukQNRZlSAAufuEuBXDEG+paoxeasWJNjHM1glzj57TODfKMh6lpDJYqQowfugDSZNfM= ansibleadmin@ip-10-0-0-6' | sudo tee -a /home/ansibleadmin/.ssh/authorized_keys
              EOF
}

