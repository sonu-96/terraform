provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.mumbai
}

resource "aws_instance" "provisioning" {
    ami = "ami-007020fd9c84e18c7"
    instance_type = "t2.micro"
    key_name = "myterra1"
    tags = {
        Name = "provisions"
    }
    security_groups = ["launch-wizard-3"]
    depends_on = [ aws_key_pair.mykey2 ]

    connection {
      type = "ssh"
      private_key = file("/home/sonu/.ssh/id_rsa")
      user = "ubuntu"
      host = self.public_ip
    }

    provisioner "file" {
      source = "test.txt"
      destination = "/home/ubuntu/test.txt"
    }
    provisioner "remote-exec" {
      #script = ""
      inline = [ "sed -i 's/PasswordAuthentication no /PasswordAuthentication yes' /etc/ssh/sshd_config" , "echo 'ubuntu:q1234' | chpasswd" ]
    }
    provisioner "local-exec" {
      command = "echo public_ip :${self.public_ip} > conf.txt ; echo private_ip :${self.private_ip} >> conf.txt"
    }

}

resource "aws_key_pair" "mykey2" {
   public_key = file ("/home/sonu/.ssh/id_rsa.pub")
   key_name = "myterra1"
}