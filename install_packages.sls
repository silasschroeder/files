install_kubernetes_app:
  cmd.run:
    - name: curl -sfL https://get.k3s.io | sh -
    - shell: /bin/bash

run_kubernetes_app:
  cmd.run:
    - name: kubectl apply -f https://raw.githubusercontent.com/silasschroeder/files/main/k8s-entities.yaml
    - require:
      - cmd: install_kubernetes_app