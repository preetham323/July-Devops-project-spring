# If you have your default VPC available then use it. 

# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the base and where to save it
source "amazon-ebs" "amazon-linux" {
  region          = "us-east-2"
  ami_name        = "ami-version-1.0.1-{{timestamp}}"
  instance_type   = "t2.micro"
  source_ami      = "ami-0d1c47ab964ae2b87"
  ssh_username    = "ec2-user"
  associate_public_ip_address = true
#  subnet_id                   = "subnet-040a331d4c3bf167e"
  security_group_id           = "sg-0d149a1aba4758012"

  #ami_users       = ["AWS Account ID"]
  ami_regions     = [
                      "us-east-2"
                    ]
}

# what to install, configure and file to copy/execute
build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]
  provisioner "ansible" {
   playbook = "playbook.yml"
}


}
