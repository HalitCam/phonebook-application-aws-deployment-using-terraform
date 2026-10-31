resource "aws_iam_role" "my_iam_role" {
  name = "phonebook-web-instance-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "my_iam_role_policy" {
  name = "${var.project_name}-iam-role-policy"
  role = aws_iam_role.my_iam_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParameter",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ssm:us-east-1:${data.aws_caller_identity.current.account_id}:parameter${var.git_token_parameter}"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.my_iam_role.name
}