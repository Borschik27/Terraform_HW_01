/*
output "vm_details" {
  value = {
    vm = {
      name        = yandex_compute_instance.vm.name
      external_ip = yandex_compute_instance.vm.network_interface.0.nat_ip_address
      fqdn        = "${yandex_compute_instance.vm.name}.${var.domain}"  # Замените на актуальное доменное имя, если у вас есть
    }
    vm-b = {
      name        = yandex_compute_instance.vm-b.name
      external_ip = yandex_compute_instance.vm-b.network_interface.0.nat_ip_address
      fqdn        = "${yandex_compute_instance.vm-b.name}.${var.domain}"  # Замените на актуальное доменное имя, если у вас есть
    }
  }
  description = "Details of the virtual machines, including name, external IP, and FQDN."
}
*/

output "vm_ip" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}