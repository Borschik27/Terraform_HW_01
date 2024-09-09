resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "my_image" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm" {
  name        = local.vm_name_main
  platform_id = var.platform_id
  resources {
    cores         = var.c_cpu
    memory        = var.mem
    core_fraction = var.c_frac
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vm_user}:${var.vms_ssh_root_key}"
  }
}

resource "null_resource" "docker_install" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.vm_user
      private_key = file("${var.path_key}")
      host        = yandex_compute_instance.vm.network_interface[0].nat_ip_address
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo usermod -aG docker ubuntu"
    ]
  }
}

provider "docker" {
  host = "ssh://${var.vm_user}@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

# Генерация случайного пароля для root
resource "random_password" "mysql_root_password" {
  length  = 16
  special = true
}

# Генерация случайного пароля для пользователя wordpress
resource "random_password" "mysql_user_password" {
  length  = 16
  special = true
}

resource "docker_image" "mysql" {
  name = var.image_docker
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.name
  name  = var.sql_db

  env = [
    "MYSQL_ROOT_PASSWORD=example_${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=${var.sql_db}",
    "MYSQL_USER=${var.sql_user}",
    "MYSQL_PASSWORD=example_${random_password.mysql_user_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]

  ports {
    internal = 3306
    external = 3306
  }
}
