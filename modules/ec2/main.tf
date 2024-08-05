resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSG"
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
              EOF
}
