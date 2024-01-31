resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl", {
    worker_ips = aws_instance.kubernetes-worker[*].public_ip
    master_ip  = aws_instance.kubernetes-master[*].public_ip
  })

  filename = "${path.module}/ansible_inventory.ini"
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/ansible_inventory.tpl")

  vars = {
    worker_ips = aws_instance.kubernetes-worker[*].public_ip
    master_ip  = aws_instance.kubernetes-master[*].public_ip
  }
}