install_kubernetes_app:
  cmd.run:
    - name: curl -sfL https://get.k3s.io | K3S_URL=https://<master_ip> K3S_TOKEN=<k8s_token> sh -
    - shell: /bin/bash
  
nfs_connect:
  cmd.run:
    - name: |
        sudo apt update
        sudo apt install nfs-common -y