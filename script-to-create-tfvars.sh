#!/bin/bash
# filepath: create-terraform-template.sh

# Create directory structure

# Create terraform.tfvars
cat > terraform.tfvars << 'EOL'
env=""
token = ""
region = ""
ssh_file_path = ""
app_info = {
    name = "jenkin",
    image_id = "114537960",
    size = "s-1vcpu-2gb-70gb-intel"
}
script_create_jenkins_file_path = "./script-create-jenkins.sh"
EOL