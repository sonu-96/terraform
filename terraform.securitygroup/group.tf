provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.mumbai 
}


resource "aws_instance" "myinst" {
    ami = "ami-007020fd9c84e18c7"
    instance_type = "t2.micro"
    #key_name = "terraformkey1"
    key_name = aws_key_pair.secrkey.key_name
    tags = {
        "Name" = "terraform_ec2"
    }
    depends_on = [ aws_key_pair.secrkey ]
    security_groups = [ aws_security_group.mysecurity.name ]
    connection {
      type = "ssh"
      private_key = file("/home/sonu/.ssh/id_rsa")
      user = "ubuntu"
      host = self.public_ip
    }
    provisioner "remote-exec" {
      script = "apache.sh"
    }
}

resource "aws_security_group" "mysecurity" {
  name = "terrasecurity"
  description = "allow inbound and outbound rules"
  tags = {
    Name = "terrasecurity"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terrasecurity_ipv4" {
  security_group_id = aws_security_group.mysecurity.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 0
  ip_protocol = "-1"
  to_port = 0

}

resource "aws_vpc_security_group_egress_rule" "terrasecurity_ipv4" {
  security_group_id = aws_security_group.mysecurity.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 0
  ip_protocol = "-1"
  to_port = 0
}

resource "aws_key_pair" "secrkey" {
    #public_key = ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqU52bn7XJXCpEVTJom7G64obfZWoy4RpXllXsmPSZ7iENAI7Ou+2DbjteoUEtqidVMI/wL+f3inz54xzAPrGzh5QugzLSm4AjtA6Vu9KRZp4KjGR6GM4tIIbIksfXV+Y+5AiHCTK+EJrCR6WRcr8Xb6IpE3m+9gv3xUFKwfCecspK2w4FzSshohL7IO3bx7eM2UsIi22OM9sTDHQpBBRDVkW3ylUkdWt6+jAcMW9oVSuZjwq/t6ZsGcadFTdXv4PzIC/SOmlbbXOK4qU17R4nsSfkPj7+Hu0ze5bm/qvRSSrMtRoGiOqqJlzdMOC+Kk9IV0pS+77sDoffuy5r0moFRhzW3cW4mAkx2wQpAulaUC1K43ElZTUiaTjyj99dG73uXE6lY8QIQ1dFSRtMukf3KBQG01Q/Yv+vAxaxWmI7WIzNHy7F8QOMS5z7f9lxF2KoKH3E4N1sXyFP7xBDQupEjJMl5Q9TohS2zHnZ2tGYAiLa4n2sZmRQ8T3SRk13DHU= sonu@sonu-Latitude-7390
    public_key = file("/home/sonu/.ssh/id_rsa.pub")
    key_name = "terraformkey1"
}