resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl", {
    master_ip   = aws_instance.kubernetes-master[0].public_ip
    worker_ips  = join("\n", tolist(aws_instance.kubernetes-worker[*].public_ip)) 
    has_workers = length(aws_instance.kubernetes-worker[*]) > 1

    // Converter os mapas de tags em strings
    master_tags = jsonencode(aws_instance.kubernetes-master[0].tags)
    worker_tags = jsonencode(aws_instance.kubernetes-worker[0].tags)
  })

  filename = "${path.module}/ansible_inventory.ini"
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/ansible_inventory.tpl")

  vars = {
    master_ip   = aws_instance.kubernetes-master[0].public_ip
    worker_ips  = join("\n", tolist(aws_instance.kubernetes-worker[*].public_ip))
    has_workers = length(aws_instance.kubernetes-worker[*]) > 1

    // Converter os mapas de tags em strings
    master_tags = jsonencode(aws_instance.kubernetes-master[0].tags)
    worker_tags = jsonencode(aws_instance.kubernetes-worker[0].tags)
  }
}