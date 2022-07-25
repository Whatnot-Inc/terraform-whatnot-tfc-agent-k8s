output "service_account_name" {
  value       = local.service_account_name
  description = "Name of the Kubernetes service account"
}

output "namespace" {
  value       = kubernetes_namespace.namespace.metadata[0].name
  description = "Name of the Kubernetes namespace"
}
