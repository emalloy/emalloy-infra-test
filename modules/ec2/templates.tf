resource "template_file" "userdataec2" {
  template = "${file("${path.module}/user-data-ec2")}"


  vars {

  }
}
