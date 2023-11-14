output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}
output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}
output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}
output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}
output "igw_id" {
  value = aws_internet_gateway.igw.vpc_id
}
output "elastic_id" {
  value = aws_eip.nat_eip.id
}
output "natgw_id" {
  value = aws_nat_gateway.natgw.id
}
output "key_name" {
  value = aws_key_pair.keypair.key_name
}
output "keypair_id" {
  value = aws_key_pair.keypair.id
}
output "private-keypair" {
  value = tls_private_key.keypair.private_key_pem
}