install_kubernetes_app:
  pkg.installed:
    - name: k3s

run_kubernetes_app:
  cmd.run:
    - name: kubectl apply -f https://raw.githubusercontent.com/silasschroeder/files/main/k8s-entities.yaml
    - require:
      - pkg: install_kubernetes_app