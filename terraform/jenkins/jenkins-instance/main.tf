resource "aws_instance" "jenkins_instance" {
  ami = "ami-055d15d9cfddf7bd3"
  instance_type = "t3.medium"
  key_name = "yusufluai"
  subnet_id = data.terraform_remote_state.main_vpc.outputs.public_subnets_id[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.main_security_group_id]
  monitoring = false
  
  provisioner "remote-exec" {
    
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install python3 -y"
    ]

    connection {
      host = self.public_ip
      user = "ubuntu"
      private_key = file("~/.ssh/yusufluai.pem")
      type = "ssh"
    }

   
  }

   provisioner "local-exec" {
      working_dir = "/home/yusuf/project/repo/sdc-project-final/ansible/playbook"
      command = "ansible-playbook -u ubuntu -i ${self.public_ip} --private-key ~/.ssh/yusufluai.pem -e  jenkins.yaml"
    }
}
