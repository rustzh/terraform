#!/bin/bash

set -e

TERRAFORM_DIR="./terraform"
ANSIBLE_INVENTORY_FILE="../ansible/inventory/hosts.ini"

# 터미널에 색상 출력용 변수
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Terraform
cd "$TERRAFORM_DIR"
echo -e "${GREEN}🔧 Initializing Terraform...${NC}"
terraform init

echo -e "${GREEN}🧠 Planning Terraform changes...${NC}"
terraform plan

echo -e "${GREEN}🚀 Applying Terraform changes...${NC}"
terraform apply -auto-approve

echo -e "${GREEN}💾 Saving output to output.txt...${NC}"
terraform output > output.txt

web01=$(terraform output -raw web01_pub_ip)
web02=$(terraform output -raw web02_pub_ip)
db01=$(terraform output -raw db01_priv_ip)

echo "[webservers]" > "$ANSIBLE_INVENTORY_FILE"
echo "web01 ansible_host=$web01" >> "$ANSIBLE_INVENTORY_FILE"
echo "web02 ansible_host=$web02" >> "$ANSIBLE_INVENTORY_FILE"
echo "" >> "$ANSIBLE_INVENTORY_FILE"
echo "[dbservers]" >> "$ANSIBLE_INVENTORY_FILE"
echo "db01 ansible_host=$db01 ansible_ssh_common_args='-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i ../terraform/my-key.pem -W %h:%p -q ec2-user@$web01\"'" >> "$ANSIBLE_INVENTORY_FILE"

cd -

echo -e "${GREEN}✅ Done!${NC}"
