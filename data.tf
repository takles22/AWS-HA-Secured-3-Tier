data "aws_ami" "image" {
  most_recent = true
  filter {
    name = "name"
    values = [ "al2023-ami*" ]
  }
  filter {
    name = "virtualization_type"
    values = [ "hvm" ]
  }
  filter {
    name = "Root_device_type"
    values = ["ebs"]
  }

  owner_id = [ "137112412989" ]
}
