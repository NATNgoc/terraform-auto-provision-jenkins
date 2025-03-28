/*
    1. Tao VPC
    2. Tao firewall (secutiry group)
    3. Tao ssh key
    4. Tao droplets
    5. Viet script automation for creating jenkin on docker
    6. Them vao user_data cho droplets
*/

variable token {
  type        = string
  description = "token to authenticate with digital ocean"
}

variable env {
    type = string
    description = "enviroment for creating infrastructures"
}

variable app_info {
    type = object({
        name: string,
        image_id: string,
        size: string
    })
    description = "name of app"
}

variable region {
    type        = string
    description = "your region for all actions"
}

variable ssh_file_path {
    type        = string
    description = "path to ssh public key"
}

variable script_create_jenkins_file_path {
    type        = string
    description = "path to create auto jenkin"
}

provider "digitalocean" {
    token = var.token
}

resource "digitalocean_vpc" "jenkin_vpc" {
  name     = "${var.env}-${var.app_info.name}-vpc"
  region   = var.region
  ip_range = "10.104.16.0/25"
}

resource "digitalocean_ssh_key" "jenkin-sshkey" {
  name       = "Terraform Example"
  public_key = file(var.ssh_file_path)
}

resource "digitalocean_firewall" "firewall" {
  name = "only-22-8080"
  droplet_ids = [digitalocean_droplet.jenkins-droplet.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}


resource "digitalocean_droplet" "jenkins-droplet" {
    name = "${var.env}-${var.app_info.name}-droplet"
    image=  var.app_info.image_id
    region   = var.region
    size = var.app_info.size
    vpc_uuid = digitalocean_vpc.jenkin_vpc.id
    ssh_keys = ["${digitalocean_ssh_key.jenkin-sshkey.id}"]
    user_data = file(var.script_create_jenkins_file_path)
}