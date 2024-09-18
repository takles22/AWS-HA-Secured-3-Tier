resource "aws_launch_template" "web" {
  count                   = var.public_subnet_count
  name_prefix  = "web-"
  image_id      = data.aws_ami.image.id # Replace with your AMI ID
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = aws_subnet.public_subnets[count.index].id
    # security_groups = aws_security_group.sg_app.id
  }

  key_name = var.key_name
  user_data = filebase64("${path.module}/script1.sh")
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "web"
  }

}

resource "aws_launch_template" "app" {
  count = var.private_subnet_count >= 2 ? 2 : 0
  name_prefix  = "app-"
  image_id      = data.aws_ami.image.id # Replace with your AMI ID
  instance_type = var.instance_type
  vpc_security_group_ids= [aws_security_group.sg_app.id]
  
  network_interfaces {
    associate_public_ip_address = false
    subnet_id = aws_subnet.private_subnets[count.index].id
    # security_groups = aws_security_group.sg_app.id
  }
#     placement {
#     availability_zone = "us-west-2a"
#   }
  key_name = var.key_name
  user_data = filebase64("${path.module}/script1.sh")
  block_device_mappings {
    device_name = "/dev/sdh"

    ebs {
      volume_size = 20
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "app"
  }

}

