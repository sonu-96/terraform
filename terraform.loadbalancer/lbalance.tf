provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.mumbai 
}


resource "aws_instance" "myinstload1" {
    ami = "ami-007020fd9c84e18c7"
    instance_type = "t2.micro"
    #key_name = "terraformkey"
    key_name = aws_key_pair.lbkey.key_name
    tags = {
        "Name" = "terraform_ec2"
    }
    depends_on = [ aws_key_pair.lbkey ]
    security_groups = [aws_security_group.web-server.id]
    subnet_id = aws_subnet.lbsubnet1.id
    user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update
             sudo apt-get install -y apache2
             sudo systemctl start apache2
             sudo systemctl enable apache2
             echo '<h1>hello this is terra1</h1>' > /var/www/html/index.html
             EOF
}

resource "aws_instance" "myinstload2" {
    ami = "ami-007020fd9c84e18c7"
    instance_type = "t2.micro"
    #key_name = "terraformkey"
    key_name = aws_key_pair.lbkey.key_name
    tags = {
        "Name" = "terraform_ec12"
    }
    depends_on = [ aws_key_pair.lbkey ]
    security_groups = [aws_security_group.web-server.id]
    subnet_id = aws_subnet.lbsubnet2.id
    user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update
             sudo apt-get install -y apache2
             sudo systemctl start apache2
             sudo systemctl enable apache2
             echo '<h1>Hello this is terra2</h1>' > /var/www/html/index.html
             EOF
}


resource "aws_key_pair" "lbkey" {
    #public_key = ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqU52bn7XJXCpEVTJom7G64obfZWoy4RpXllXsmPSZ7iENAI7Ou+2DbjteoUEtqidVMI/wL+f3inz54xzAPrGzh5QugzLSm4AjtA6Vu9KRZp4KjGR6GM4tIIbIksfXV+Y+5AiHCTK+EJrCR6WRcr8Xb6IpE3m+9gv3xUFKwfCecspK2w4FzSshohL7IO3bx7eM2UsIi22OM9sTDHQpBBRDVkW3ylUkdWt6+jAcMW9oVSuZjwq/t6ZsGcadFTdXv4PzIC/SOmlbbXOK4qU17R4nsSfkPj7+Hu0ze5bm/qvRSSrMtRoGiOqqJlzdMOC+Kk9IV0pS+77sDoffuy5r0moFRhzW3cW4mAkx2wQpAulaUC1K43ElZTUiaTjyj99dG73uXE6lY8QIQ1dFSRtMukf3KBQG01Q/Yv+vAxaxWmI7WIzNHy7F8QOMS5z7f9lxF2KoKH3E4N1sXyFP7xBDQupEjJMl5Q9TohS2zHnZ2tGYAiLa4n2sZmRQ8T3SRk13DHU= sonu@sonu-Latitude-7390
    public_key = file("/home/sonu/.ssh/id_rsa.pub")
    key_name = "terralbkey"
}