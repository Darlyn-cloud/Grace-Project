# Networking for Project Grace IT

resource "aws_vpc" "Pro-vpc" {

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Pro-vpc "
  }
}

# Public Subnet 1

resource "aws_subnet" "Pro-pub-sub-1" {
  vpc_id            = aws_vpc.Pro-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Pro-pub-sub-1"
  }
}

resource "aws_subnet" "Pro-pub-sub-2" {
  vpc_id            = aws_vpc.Pro-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Pro-pub-sub-2"
  }
}



# Private Subnet

resource "aws_subnet" "Pro-priv-subnet-1" {
  vpc_id            = aws_vpc.Pro-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Pro-priv-subnet-1"
  }
}


resource "aws_subnet" "Pro-priv-subnet-2" {
  vpc_id            = aws_vpc.Pro-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Pro-priv-subnet-2"
  }
}



# Public RT

resource "aws_route_table" "Pro-pub-RT" {
  vpc_id = aws_vpc.Pro-vpc.id

  tags = {
    Name = "Pro-pub-Route-table"
  }
}

# Associte public subnet to public RT

resource "aws_route_table_association" "Pro-Route-Table-Assoc-to-Pub-subnet" {
  subnet_id      = aws_subnet.Pro-pub-sub-1.id
  route_table_id = aws_route_table.Pro-pub-RT.id
}

resource "aws_route_table_association" "Pro-Rout-Table-Assoc-to-Pub-subnet" {
  subnet_id      = aws_subnet.Pro-pub-sub-2.id
  route_table_id = aws_route_table.Pro-pub-RT.id
}


# Private RT

resource "aws_route_table" "Pro-priv-RT" {
  vpc_id = aws_vpc.Pro-vpc.id

  tags = {
    Name = "Pro-priv-RT"
  }
}

# Associte private subnet to private RT

resource "aws_route_table_association" "Pro-route-table-Assoc-to-Pub-subnet" {
  subnet_id      = aws_subnet.Pro-priv-subnet-1.id
  route_table_id = aws_route_table.Pro-priv-RT.id

}

resource "aws_route_table_association" "Pro-rout-table-Assoc-to-Pub-subnet" {
  subnet_id      = aws_subnet.Pro-priv-subnet-2.id
  route_table_id = aws_route_table.Pro-priv-RT.id

}

# Internet Gateway 

resource "aws_internet_gateway" "Pro-Igw" {
  vpc_id = aws_vpc.Pro-vpc.id

  tags = {
    Name = "Pro-Igw"
  }
}

# Internet Gateway Route Table Association
resource "aws_route" "Pro-Igw-assoc-Pro-pub-RT" {
  gateway_id             = aws_internet_gateway.Pro-Igw.id
  route_table_id         = aws_route_table.Pro-pub-RT.id
  destination_cidr_block = "0.0.0.0/0"
}


# Create Elastic IP Address

resource "aws_eip" "Pro-EIP-address" {
  tags = {
    Name = "Pro-EIP-address"
  }
}


# Create NAT Gateway

resource "aws_nat_gateway" "Pro-Nat-Gateway" {
  allocation_id = aws_eip.Pro-EIP-address.id
  subnet_id     = aws_subnet.Pro-pub-sub-1.id

  tags = {
    Name = "Pro-Nat-Gateway"
  }

}





# NAT Associate with Priv route

resource "aws_route" "Pro-Nat-Gateway-Pro-priv-RT" {
  route_table_id         = aws_route_table.Pro-priv-RT.id
  gateway_id             = aws_nat_gateway.Pro-Nat-Gateway.id
  destination_cidr_block = "0.0.0.0/0"
} 

