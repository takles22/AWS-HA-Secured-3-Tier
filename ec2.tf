resource "aws_key_pair" "ssh_key" {
  key_name = "memo_key"
  public_key = file("~/.ssh/memo.pub")
}


resource "aws_instance" "web_ec2" {
  count = 2
  ami           = data.aws_ami.image.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_1.id
  key_name = "memo_key"
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = ("~/.ssh/memo")
    host = self.private_ip
  }
  user_data = filebase64("${path.module}/script1.sh")
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  tags = {
    Name = "HA-web-${count.index}"
  }
}

resource "aws_instance" "app_ec2" {
  count = 2
  ami           = data.aws_ami.image.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_subnet_1.id
  key_name = "memo_key"
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = ("~/.ssh/memo")
    host = self.private_ip
  }
  user_data = filebase64("${path.module}/script1.sh")
  vpc_security_group_ids = [aws_security_group.sg_app.id]

  tags = {
    Name = "HA-app-${count.index}"
  }
}
