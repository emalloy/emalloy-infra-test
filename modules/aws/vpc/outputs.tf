output "vpc_id" {
  value = "${aws_vpc.emalloy-ro-test.id}"
}

output "ec2_sg_id" {
  value = "${aws_security_group.emalloy-ro-test.id}"
}

output "ec2_keypair" {
  value = "${aws_key_pair.emalloy-ro-test.id}"
}


output "ec2_subnet_id" {
  value = "${aws_subnet.eu-central-1a-public.id}"
}

//output "dependency_id" {
//  value = "${null_resource.module_dependency.id}"
//}

