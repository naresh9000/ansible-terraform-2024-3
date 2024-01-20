output "networking" {
  value = {

    vpc_cidr = "${data.aws_vpc.ansible-vpc.cidr_block}"
  }
}


