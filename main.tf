locals {
  service_account_name = var.deployment_name
  deployment_name      = var.deployment_name
}

resource "tfe_agent_pool" "this" {
  organization = var.tfc_organization_name
  name         = local.deployment_name
}

resource "tfe_agent_token" "this" {
  agent_pool_id = tfe_agent_pool.this.id
  description   = var.tfc_agent_name
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "kubernetes_service_account" "service_account" {
  metadata {
    name        = local.service_account_name
    namespace   = kubernetes_namespace.namespace.metadata.name
    annotations = var.service_account_annotations
  }
}

resource "kubernetes_secret" "secret" {
  metadata {
    name      = local.deployment_name
    namespace = kubernetes_namespace.namespace.metadata.name
  }

  data = {
    token = tfe_agent_token.this.token
  }
}

resource "kubernetes_deployment" "tfc_cloud_agent" {
  metadata {
    name      = local.deployment_name
    namespace = local.namespace
    labels    = var.tags
  }
  spec {
    selector {
      match_labels = var.tags
    }
    replicas = var.replicas

    template {
      metadata {
        namespace   = local.namespace
        labels      = var.tags
        annotations = var.deployment_annotations
      }
      spec {
        service_account_name            = local.service_account_name
        automount_service_account_token = true
        container {
          image = var.agent_image
          name  = "tfc-agent"
          args  = var.agent_cli_args
          env {
            name = "TFC_AGENT_TOKEN"
            value_from {
              secret_key_ref {
                key  = "token"
                name = local.deployment_name
              }
            }
          }
          env {
            name  = "TFC_AGENT_NAME"
            value = var.tfc_agent_name
          }
          env {
            name  = "TFC_AGENT_LOG_LEVEL"
            value = var.tfc_agent_log_level
          }
          env {
            name  = "TFC_AGENT_SINGLE"
            value = var.tfc_agent_single
          }
          env {
            name  = "TFC_AGENT_DISABLE_UPDATE"
            value = var.tfc_agent_disable_update
          }
          env {
            name  = "TFC_ADDRESS"
            value = var.tfc_address
          }
          dynamic "env" {
            for_each = var.tfc_agent_data_dir == null ? [] : [1]
            content {
              name  = "TFC_AGENT_DATA_DIR"
              value = var.tfc_agent_data_dir
            }
          }
          dynamic "env" {
            for_each = var.agent_envs
            content {
              name  = env.key
              value = env.value
            }
          }
          resources {
            limits = {
              cpu    = var.resource_limits_cpu
              memory = var.resource_limits_memory
            }
            requests = {
              cpu    = var.resource_requests_cpu
              memory = var.resource_requests_memory
            }
          }
        }
      }
    }
  }
}
