resource "yandex_compute_instance" "node-1" {
  name = "node-1-jenkins"
  platform_id = "standard-v2"

  depends_on = [ yandex_vpc_subnet.subnet-c-1 ]

  resources {
    cores  = 2
    memory = 2 
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-1-jenkins.id
      size = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-c-1.id
    nat       = true
  }

  metadata = {
    user-data = file("users.yaml")
	"serial-port-enable": "1"
  }
}
