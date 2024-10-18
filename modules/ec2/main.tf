resource "aws_instance" "ec2" {
  ami           = "ami-064519b8c76274859"  # Debian
  instance_type = "t2.micro"
  subnet_id     = var.subnet-id
  key_name      = var.key-name

  vpc_security_group_ids = [var.security-group-id]

  associate_public_ip_address = true

   root_block_device {
     volume_type = "gp3"
     volume_size = 8
     delete_on_termination = true
     tags = {
       Name = "${var.prefix}-volume"
     }
   }

  tags = {
    Name = "${var.prefix}-ec2"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id

  tags = {
    Name = "${var.prefix}-eip"
  }
}
