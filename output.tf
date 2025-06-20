output "k3s_master_ip" {
  value = aws_instance.k3s_nodes[0].public_ip
}
