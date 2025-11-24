locals {
  role_name          = lower("${var.machine_prefix}-ec2-instance-profile")
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "instance_profile_role" {
  name = local.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "managed_ssm_instance_policy" {
  role       = aws_iam_role.instance_profile_role.name
  policy_arn = local.managed_policy_arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = local.role_name
  role = aws_iam_role.instance_profile_role.name
  tags = var.tags
}
