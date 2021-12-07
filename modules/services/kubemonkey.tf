resource "helm_release" "kube_monkey" {
  count      = local.kubemonkey_enabled ? 1 : 0
  name       = "kubemonkey"
  chart      = "kube-monkey"
  repository = "https://asobti.github.io/kube-monkey/charts/repo"
  namespace  = kubernetes_namespace.addons.metadata[0].name

  values = [
    templatefile("${path.module}/kubemonkey-values.yml.tmpl", {
      timeZone : local.kubemonkey_time_zone
      whitelistedNamespaces : local.kubemonkey_whitelisted_namespaces
      notificationUrl : local.kubemonkey_notification_url
    })
  ]
}
