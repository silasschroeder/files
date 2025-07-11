k3s_master_install:
  cmd.run:
    - name: curl -sfL https://get.k3s.io | sh -

k3s_load_entity-yaml:
  cmd.run:
    - name: curl -sfL https://raw.githubusercontent.com/silasschroeder/files/main/k8s-entities.yaml | sudo tee /home/ubuntu/k8s-entities.yaml
    - require:
      - cmd: k3s_master_install

k3s_master_ip_extract:
  cmd.run:
    - name: ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d'/' -f1 | head -n 1 > /home/ubuntu/master_ip.txt
    - creates: /home/ubuntu/master_ip.txt
    - require:
        - cmd: k3s_master_install

k3s_master_token_extract:
  cmd.run:
    - name: cat /var/lib/rancher/k3s/server/node-token > /home/ubuntu/master_token.txt
    - creates: /home/ubuntu/master_token.txt
    - require:
        - cmd: k3s_master_install

nfs_install:
  cmd.run:
    - name: |
        sudo apt update
        sudo apt install nfs-kernel-server -y
        sudo mkdir -p /mnt/data
        sudo chown nobody:nogroup /mnt/data
        sudo chmod 777 /mnt/data
        echo "/mnt/data *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports
        sudo exportfs -a
        sudo systemctl restart nfs-kernel-server
        sudo systemctl enable nfs-kernel-server
    - require:
        - cmd: k3s_master_install