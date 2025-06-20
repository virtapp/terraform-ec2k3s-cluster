output "k3s_master_ip" {
  value = tolist(aws_instance.k3s_nodes.*.public_ip)[0]
}
