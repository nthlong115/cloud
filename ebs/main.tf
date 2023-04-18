resource "aws_ebs_volume" "aws_ebs" {
  size = 100
}

resource "aws_volume_attachment" "to_pub_ec2" {
  device_name = "vol1"
  volume_id = aws_ebs_volume.aws_ebs.id
  instance_id = var.outec2
}