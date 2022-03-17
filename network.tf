resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-central-1a"

    tags = {
        Name = "subnet1-a"
    }
    
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-central-1b"

    tags = {
        Name = "subnet2-b"
    }
    
}

resource "aws_internet_gateway" "igw-main" {

    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "igw-main"
    }
  
}

resource "aws_route_table" "route-tbl-global" {

    vpc_id = aws_vpc.main-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-main.id
    }

    tags = {
        Name = "route-tbl-1"
    }
  
}

resource "aws_route_table_association" "route-tbl-subnet-1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route-tbl-global.id
  
}

resource "aws_route_table_association" "route-tbl-subnet-2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route-tbl-global.id
  
}

resource "aws_security_group" "sec-group" {  
  vpc_id = aws_vpc.main-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    "Name" = "sec-group-rdp-http-winrm"
  }
}

