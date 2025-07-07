install_kubernetes_app:
  pkg.installed:
    - name: k3s

run_kubernetes_app:
  cmd.run:
    - name: kubectl apply -f https://github.com/silasschroeder/files/blob/main/k8s-entities.yaml
    - require:
      - pkg: install_kubernetes_app