resource "aws_instance" "web_host" {
  # ec2 have plain text secrets in user data
  ami           = "${var.ami}"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
  "${aws_security_group.web-node.id}"]
  subnet_id = "${aws_subnet.web_subnet.id}"
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-west-2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_host"
    yor_trace            = "0b197d7c-82fc-40fa-b3aa-025805052eea"
  }
}

resource "aws_ebs_volume" "web_host_storage" {
  # unencrypted volume
  availability_zone = "${var.region}a"
  #encrypted         = false  # Setting this causes the volume to be recreated on apply 
  size = 1

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_host_storage"
    yor_trace            = "cfdc99da-12f8-4454-8c87-09b20dac7f73"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  # ebs snapshot without encryption
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  description = "${local.resource_prefix.value}-ebs-snapshot"

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "example_snapshot"
    yor_trace            = "a17143b8-8c16-4caa-8c64-218d44bf0bdd"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  instance_id = "${aws_instance.web_host.id}"
}

resource "aws_security_group" "web-node" {
  # security group is open to the world in SSH port
  name        = "${local.resource_prefix.value}-sg"
  description = "${local.resource_prefix.value} Security Group"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  depends_on = [aws_vpc.web_vpc]

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web-node"
    yor_trace            = "b3576392-3e09-450f-8a10-3a77aae9335f"
  }
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_vpc"
    yor_trace            = "75842732-4419-444a-a3f4-a4f3a3acd41f"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true


  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_subnet"
    yor_trace            = "0081fd79-5a0b-4eea-9520-9c764955bfa4"
  }
}

resource "aws_subnet" "web_subnet2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.11.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true


  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_subnet2"
    yor_trace            = "95cfd0fb-6114-4c25-8b48-cb027f6b7723"
  }
}


resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_igw"
    yor_trace            = "91c0dcbc-7524-4ab9-b38a-61c73461cf11"
  }
}

resource "aws_route_table" "web_rtb" {
  vpc_id = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web_rtb"
    yor_trace            = "61d0af6c-f96d-456b-9a1f-3b06ea91abaf"
  }
}

resource "aws_route_table_association" "rtbassoc" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route_table_association" "rtbassoc2" {
  subnet_id      = aws_subnet.web_subnet2.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.web_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_igw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_network_interface" "web-eni" {
  subnet_id   = aws_subnet.web_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "web-eni"
    yor_trace            = "a367ec66-ef7d-4d1a-8d24-fab77d610b95"
  }
}

# VPC Flow Logs to S3
resource "aws_flow_log" "vpcflowlogs" {
  log_destination      = aws_s3_bucket.flowbucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "vpcflowlogs"
    yor_trace            = "986b86f3-51ad-4425-9e09-9969052e6cbb"
  }
}

resource "aws_s3_bucket" "flowbucket" {
  bucket        = "${local.resource_prefix.value}-flowlogs"
  force_destroy = true

  tags = {
    git_commit           = "2efe3c6affeda826b8836804ab477cbad504245c"
    git_file             = "deployment_ec2.tf"
    git_last_modified_at = "2024-12-12 09:38:13"
    git_last_modified_by = "paschoal.diniz@gmail.com"
    git_modifiers        = "paschoal.diniz"
    git_org              = "kbcasurf"
    git_repo             = "devsecops-checkov"
    yor_name             = "flowbucket"
    yor_trace            = "6332e58b-2df8-49aa-b550-98ecc76e792e"
  }
}

# OUTPUTS
output "ec2_public_dns" {
  description = "Web Host Public DNS name"
  value       = aws_instance.web_host.public_dns
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.web_vpc.id
}

output "public_subnet" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet.id
}

output "public_subnet2" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet2.id
}
