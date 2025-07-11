install_kubernetes_app:
  cmd.run:
    - name: curl -sfL https://get.k3s.io | K3S_URL=https://<master_ip>:6443 K3S_TOKEN=<k8s_token> sh -
  
nfs_connect:
  cmd.run:
    - name: |
        sudo apt update
        sudo apt install nfs-common -y