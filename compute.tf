
resource "aws_instance" "wordpress_server" {
  ami                    = "ami-0322211ccfe5b6a20" # Ubuntu LTS 20.04, eu-west-3
  instance_type          = "t2.micro"
  key_name               = "TF_key"
  vpc_security_group_ids = [aws_security_group.ec2_allow_http_ssh_sg.id]
  subnet_id              = aws_subnet.private_subnet_1.id
  tags = {
    Name = "Wordpress Server"
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

# This resource is used to connect to the EC2 instance using the EC2 Instance Connect feature.
# It is needed because the EC2 instance is in a private subnet and does not have a public IP address.
# An alternative way is to define another "aws_instance" that is in a public subnet and use it to connect to the EC2 instance in the private subnet,
# and we would call it a "bastion host".
resource "aws_ec2_instance_connect_endpoint" "wordpress_ec2_connect_endpoint" {
  subnet_id          = aws_subnet.public_subnet_1.id
  security_group_ids = [aws_security_group.ec2_allow_http_ssh_sg.id]
  preserve_client_ip = false
}
