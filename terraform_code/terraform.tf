provider "aws"{
    region = "us-east-1"
} 

resource "aws_instance" "demo-server"{
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = "DevOpsProjectKey"
    # security_groups = ["SG-devops-2"]
    vpc_security_group_ids = [aws_security_group.SG-devops-2.id]
    subnet_id = aws_subnet.public-subnets-01.id 
    for_each = toset(["Jenkins-master","Build-slave","Ansible"])
    tags = {
      Name = "${each.key}"
    }
}

resource "aws_security_group" "SG-devops-2" {
  name        = "SG-devops-2"
  description = "SSH access inbound traffic"
  vpc_id      = aws_vpc.vpc-main.id

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

resource "aws_vpc" "vpc-main" {
 cidr_block = "10.1.0.0/16"
 
 tags = {
   Name = "vpc-main"
 }
}

resource "aws_subnet" "public-subnets-01" { 
 vpc_id     = aws_vpc.vpc-main.id
 cidr_block = "10.1.1.0/24"
 map_public_ip_on_launch = "true"
 availability_zone = "us-east-1a"
 
 tags = {
   Name = "public-subnets-01"
 }
}

resource "aws_subnet" "public-subnets-02" { 
 vpc_id     = aws_vpc.vpc-main.id
 cidr_block = "10.1.2.0/24"
 map_public_ip_on_launch = "true"
 availability_zone = "us-east-1b"
 
 tags = {
   Name = "public-subnets-02"
 }
}

resource "aws_internet_gateway" "gw-main" {
 vpc_id = aws_vpc.vpc-main.id
 
 tags = {
   Name = "gw-main"
 }
}


resource "aws_route_table" "public-rt-main" {
 vpc_id = aws_vpc.vpc-main.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw-main.id
 }
 
 tags = {
   Name = "public-rt-main"
 }
}

resource "aws_route_table_association" "rta-subnet-01" {
 subnet_id      = aws_subnet.public-subnets-01.id
 route_table_id = aws_route_table.public-rt-main.id
}

resource "aws_route_table_association" "rta-subnet-02" {
 subnet_id      = aws_subnet.public-subnets-02.id
 route_table_id = aws_route_table.public-rt-main.id
}





