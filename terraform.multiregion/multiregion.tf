provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.mumbai
    alias = "south"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-west-1"
  alias = "west"
}

resource "aws_instance" "myinst1" {
    provider = aws.south
  ami = "ami-007020fd9c84e18c7"
  instance_type = "t2.micro"
  key_name = "myterra1"
  security_groups = [ "default" ]
  tags = {
    "Name" = "my_ec2_1"
  }
  depends_on = [ aws_key_pair.mykey ]
}

resource "aws_instance" "myinst2" {
    provider = aws.west
  ami = "ami-05c969369880fa2c2"
  instance_type = "t2.micro"
  key_name = "myterra1"
  security_groups = [ "default" ]
  tags = {
    "Name" = "my_ec2_2"
  }
  depends_on = [ aws_key_pair.mykey1 ]
}

resource "aws_key_pair" "mykey" {

  provider = aws.south
  public_key = file ("/home/sonu/.ssh/id_rsa.pub")
  key_name = "myterra1"
}

resource "aws_key_pair" "mykey1" {
  provider = aws.west
  public_key = file ("/home/sonu/.ssh/id_rsa.pub")
  key_name = "myterra1"
}