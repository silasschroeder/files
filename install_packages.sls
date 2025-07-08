install_kubernetes_app:
  cmd.run:
    - name: curl -sfL https://get.k3s.io | sh -
    - shell: /bin/bash

run_kubernetes_app:
  cmd.run:
    - name: kubectl apply -f https://raw.githubusercontent.com/silasschroeder/files/main/k8s-entities.yaml
    - require:
      - cmd: install_kubernetes_app

install_helm:
  cmd.run:
    - name: |
        wget https://get.helm.sh/helm-v3.18.3-linux-amd64.tar.gz && \
        tar xzf helm-v3.18.3-linux-amd64.tar.gz && \
        sudo cp linux-amd64/helm /usr/local/sbin
    - shell: /bin/bash
    - require:
      - cmd: install_kubernetes_app

helm_install_prometheus:
  cmd.run:
    - name: |
        helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
        helm repo update && \
        mkdir -p /home/ubuntu/.kube && \
        sudo cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config && \
        sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config && \
        export KUBECONFIG=/home/ubuntu/.kube/config && \
        helm install prometheus prometheus-community/prometheus
    - shell: /bin/bash
    - require:
      - cmd: install_helm
