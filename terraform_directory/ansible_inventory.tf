resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl", {
    instance_ips = aws_instance.example[*].public_ip
  })

  filename = "${path.module}/ansible_inventory.ini"
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/ansible_inventory.tpl")

  vars = {
    instance_ips = aws_instance.example[*].public_ip
  }
}