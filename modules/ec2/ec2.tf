resource "aws_launch_configuration" "emalloy-ro-test" {

  image_id = "${var.ubuntu_ami}"
  name = "emalloy-ro-test"
  instance_type = "t2.large"
  associate_public_ip_address = true
  key_name = "${var.aws_key_name}"
  security_groups = [ "${var.security_group}" ]
  user_data = "${template_file.userdataec2.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.server_s3.name}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 40
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  connection {
    user  = "ubuntu"
    agent = true
  }
}

resource "aws_autoscaling_group" "emalloy-ro-test" {
  vpc_zone_identifier = [ "${split(",", var.subnets)}" ]
  name = "emalloy-ro-test"
  max_size = 1
  min_size = 1

  health_check_grace_period = 100
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.emalloy-ro-test.name}"

  tag {
    key = "Role"
    value = "sample"

    propagate_at_launch = true
  }

  depends_on = [
    "aws_launch_configuration.emalloy-ro-test",
    "aws_iam_policy_attachment.server_s3"
  ]
}

resource "null_resource" "module_dependency" {
  depends_on = ["aws_autoscaling_group.emalloy-ro-test"]
}
