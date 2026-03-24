terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.193.0"
    }
  }
}

variable "env_name" {
  type        = string
  description = "name (develop)"
}

variable "zone" {
  type        = string
  description = "zone for the subnet"
}

variable "cidr" {
  type        = string
  description = "CIDR block"
}

resource "yandex_vpc_network" "dev-oll" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "dev-oll" {
  name           = "${var.env_name}-${var.zone}"
  zone           = var.zone
  network_id     = yandex_vpc_network.dev-oll.id
  v4_cidr_blocks = [var.cidr]
}

output "subnet_info" {
  description = "Complete subnet object with all attributes"
  value       = yandex_vpc_subnet.dev-oll
}

output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.dev-oll.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.dev-oll.id
}
