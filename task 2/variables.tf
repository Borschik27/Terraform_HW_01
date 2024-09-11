###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "default"
  description = "VPC network & subnet name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
  default     = ["10.1.1.0/24"]
}

variable "network_id" {
  type        = string
  description = " network id"
}

variable "ppkyc" {
  type        = string
  description = "Path to key"
}


variable "image_family" {
  type        = string
  description = "Image family for the VM"
}

variable "platform_id" {
  type        = string
  description = "Platform ID for the VM"
}

variable "vm_name" {
  type        = string
  default     = "default"
  description = "VM Name"
}

variable "c_cpu" {
  type        = number
  default     = 2
  description = "Number of CPU cores for the VM"
}

variable "mem" {
  type        = number
  default     = 2
  description = "Memory in GB for the VM"
}

variable "c_frac" {
  type        = number
  default     = 50
  description = "Core fraction for the VM"
}

variable "vm_user" {
  type        = string
  description = "SSH user for the VM"
}

variable "vms_ssh_root_key" {
  type        = string
  description = "SSH root key for the VM"
}

###loacls
variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., dev, prod)"
}

variable "vm_id_main" {
  type        = string
  description = "ID for the main VM"
}

variable "vm_id_db" {
  type        = string
  description = "ID for the database VM"
}

variable "domain" {
  type        = string
  description = "Domain name"
}

variable "sql_db" {
  type        = string
  description = "DB name"
}

variable "sql_user" {
  type        = string
  description = "DB user name"
}

variable "path_key" {
  type        = string
  description = "Path to key"
}

variable "ip_db" {
  type        = string
  description = "IP db"
}

variable "image_docker" {
  type        = string
  description = "Image name"
}

