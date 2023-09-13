provider "aws"{
    region = "us-east-1"
} 

resource "aws_instance" "demo-server"{
    ami = "ami-01c647eace872fc02"
    instance_type = "t2.micro"
    key_name = "DevOpsProjectKey"
    security_groups = ["SG-devops-2"]
}

resource "aws_security_group" "SG-devops-2" {
  name        = "SG-devops-2"
  description = "SSH access inbound traffic"

  ingress {
    description      = "SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSH-port"
  }
}