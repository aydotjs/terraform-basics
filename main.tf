resource "aws_instance" "web" {
  ami           = "ami-089146c5626baa6bf"
  instance_type = "t3.micro"

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
    Name = "terraform-demo-server"
  }
}