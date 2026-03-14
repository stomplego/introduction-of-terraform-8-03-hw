terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  required_version = "~>1.12.0"
}

provider "docker" {}

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "hello_world" {
  name  = "example-${random_password.random_string.result}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 9090
  }
}
