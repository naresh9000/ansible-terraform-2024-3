data "aws_vpc" "ansible-vpc" {
  id = var.peer_vpc_id
}

data "aws_route_table" "ansible-vpc-route-table" {
  route_table_id = var.peer_rt_id

}

resource "aws_vpc_peering_connection" "peering_connection_to_ansible_controller" {
  #self account ,so peer_owner_id is not required
  #peer_owner_id = "account-id-of-vpc-b"
  #ansible-controller-vpc-B ,3-instances in - vpc-A

  peer_vpc_id = data.aws_vpc.ansible-vpc.id
  vpc_id      = aws_vpc.default.id
  auto_accept = true # You can set this based on your preference
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = "vpc-peering"
  }
}

# Update route tables in VPC-B
resource "aws_route" "route_to_vpc_B" {
  route_table_id            = aws_route_table.terrform-public-rtb.id
  destination_cidr_block    = data.aws_vpc.ansible-vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection_to_ansible_controller.id
}

# Update route tables in VPC-B
resource "aws_route" "route_to_vpc_A" {
  route_table_id            = data.aws_route_table.ansible-vpc-route-table.route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection_to_ansible_controller.id
}
