# resource "aws_route_table" "public" {
#   vpc_id = var.vpc_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = data.aws_internet_gateway.vpc_default.internet_gateway_id
#   }
# }

# resource "aws_subnet" "public" {
#   vpc_id     = var.vpc_id
#   cidr_block = "10.0.0.0/24"
# }


# resource "aws_nat_gateway" "public_to_nat" {
#   #   allocation_id = aws_eip.example.id
#   subnet_id = aws_subnet.public.id

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   #   depends_on = [aws_internet_gateway.example]
# }

# resource "aws_route_table" "public" {
#   vpc_id = var.vpc_id

#   route {
#     cidr_block = "0.0.0.0/0"
#     # gateway_id = aws_internet_gateway.example.id
#   }
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.example.id

#   route {
#     cidr_block     = "10.0.1.0/24"
#     nat_gateway_id = aws_nat_gateway.public_to_nat.id
#   }
# }

