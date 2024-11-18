resource "aws_security_group" "ec2_allow_http_ssh_sg" {
  vpc_id = aws_vpc.my_new_vpc.id
  ingress {
    description = "Allow SSH access from specific IP"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["your-ip-address/32"] # Replace with your IP
  }
  ingress {
    description = "Allow HTTP access from anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all traffic to go out"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "Allow all traffic to go out"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.my_new_vpc.id
  ingress {
    description = "Allow MySQL/Aurora access from EC2 instances"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # Specify the security group that will be assigned to the EC2 instance
    security_groups = [aws_security_group.ec2_allow_http_ssh_sg.id]
  }
  egress {
    description = "Allow all traffic to go out"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.my_new_vpc.id
  ingress {
    description = "Allow HTTP access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description      = "Allow all traffic to go out"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}