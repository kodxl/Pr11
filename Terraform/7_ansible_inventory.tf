resource "local_file" "hosts_cfg" {
  content = templatefile("inventory.tftpl",
    {
      ci_server = yandex_compute_instance.node-1.network_interface.0.nat_ip_address
    }
  )
  filename = "../Ansible/inventory.inv"
}
