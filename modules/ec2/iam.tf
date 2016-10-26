resource "aws_iam_instance_profile" "server_s3" {
  name = "emalloy-ro-test-server-s3-profile"
  roles = [ "${aws_iam_role.server_s3.name}" ]
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "aws_iam_role" "server_s3" {
  name = "emalloy-ro-test-server-s3-role"
  path = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "server_s3" {
  name       = "emalloy-ro-test-server-s3"
  roles      = [ "${aws_iam_role.server_s3.name}" ]
  policy_arn = "${aws_iam_policy.server_policy.arn}"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_iam_policy" "server_policy" {
  name = "emalloy-ro-test-server-s3-policy"
  path = "/"
  description = "iam instance policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action":["ec2:*"
      ],
      "Resource":[
        "*"
      ]
    }
  ]
}
EOF
}

