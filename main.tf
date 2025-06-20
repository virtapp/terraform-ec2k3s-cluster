resource "aws_instance" "k3s_nodes" {
  count         = var.master_count + var.worker_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = count.index < var.master_count ? "k3s-master-${count.index}" : "k3s-worker-${count.index - var.master_count}"
    Role = count.index < var.master_count ? "master" : "worker"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "install-k3s.sh"
    destination = "/tmp/install-k3s.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-k3s.sh",
      "bash /tmp/install-k3s.sh ${count.index} ${aws_instance.k3s_nodes[0].private_ip} ${var.master_count}"
    ]
  }
}
