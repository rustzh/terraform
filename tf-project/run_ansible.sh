#!/bin/bash

set -e

ANSIBLE_DIR="./ansible"

# 터미널에 색상 출력용 변수
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Ansible
cd "$ANSIBLE_DIR"
echo -e "${GREEN}🚀 Running playbook site.yml..${NC}"
ansible-playbook site.yml
