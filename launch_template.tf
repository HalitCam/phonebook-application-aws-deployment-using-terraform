resource "aws_launch_template" "my_launch_template" {
  name                   = "${var.project_name}-launch-template"
  image_id               = data.aws_ami.web_server_ami.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_web_sg.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.web_instance_profile.name
  }

  user_data = base64encode(<<-EOF
              #! /bin/bash
              dnf update -y
              dnf install -y python3-pip git
              pip3 install flask==2.3.3 flask-mysql cryptography

              TOKEN=$(aws ssm get-parameter --name "/phonebook/github/token" --with-decryption --query Parameter.Value --output text --region us-east-1)
              cd /home/ec2-user
              git clone https://$TOKEN@github.com/HalitCam/phonebook-application-aws-deployment-using-terraform.git
              unset TOKEN
              cd /home/ec2-user/phonebook-application-aws-deployment-using-terraform
              echo 'export MYSQL_DATABASE_HOST="${aws_db_instance.my_db_instance.address}"' > /etc/profile.d/mysql.sh
              chmod +x /etc/profile.d/mysql.sh
              ./etc/profile.d/mysql.sh
              python3 phonebook-app.py
              EOF
  )


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-instance"
    }
  }
}