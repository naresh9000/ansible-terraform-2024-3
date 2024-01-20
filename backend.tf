terraform {
  backend "s3" {
    bucket = "devops-state-store"
    key    = "ansible.tfstate"
    region = "ap-south-2"
  }
}
