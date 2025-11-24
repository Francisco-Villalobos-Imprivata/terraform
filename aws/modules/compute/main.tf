resource "aws_instance" "appliance" {
  count = length(var.appliances)

  ami           = var.image_id
  instance_type = var.appliances[count.index].instance_type

  primary_network_interface {
    network_interface_id = var.network_interface_ids[count.index]
  }

  root_block_device {
    delete_on_termination = false
    encrypted             = true
    tags = {
      Name = "${var.machine_prefix}-${var.appliances[count.index].instance_index}-os-disk"
    }
    volume_type = "gp3"
    iops        = var.disk_iops_override
  }
  iam_instance_profile = var.ec2_instance_profile_name
  user_data            = <<-EOF
    #!/bin/bash

    HOSTNAME="${var.machine_prefix}-${var.appliances[count.index].instance_index}"
    hostnamectl set-hostname "$HOSTNAME"
    echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
  EOF

  tags = merge({
    Name = "${var.machine_prefix}-${var.appliances[count.index].instance_index}"
    },
    var.tags
  )
}
