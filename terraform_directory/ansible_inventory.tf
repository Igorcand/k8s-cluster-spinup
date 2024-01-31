resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl", {
    master_ip   = aws_instance.kubernetes-master[0].public_ip
    worker_ips  = formatlist("%s", aws_instance.kubernetes-worker[*].public_ip)
    has_workers = length(aws_instance.kubernetes-worker[*]) > 1
  })

  filename = "${path.module}/ansible_inventory.ini"
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/ansible_inventory.tpl")

  vars = {
    master_ip   = aws_instance.kubernetes-master[0].public_ip
    worker_ips  = join(", ", aws_instance.kubernetes-worker[*].public_ip)
    has_workers = length(aws_instance.kubernetes-worker[*]) > 1
  }
}
