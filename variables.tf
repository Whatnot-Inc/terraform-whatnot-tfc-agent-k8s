variable "agent_image" {
  type        = string
  default     = "hashicorp/tfc-agent:latest"
  description = "Name and tag of Terraform Cloud Agent docker image"
}

variable "agent_cli_args" {
  type        = list(string)
  default     = []
  description = "Extra command line arguments to pass to tfc-agent"
}

variable "agent_envs" {
  type        = map(string)
  default     = {}
  description = "A map of any extra environment variables to pass to the TFC agent"
}

variable "deployment_annotations" {
  type        = map(string)
  default     = {}
  description = "Annotations to add to the Kubernetes deployment"
}

variable "deployment_name" {
  type        = string
  default     = "tfc-agent"
  description = "The deployment name in Kubernetes"
}

variable "kubernetes_namespace" {
  type        = string
  description = "The Kubernetes namespace the agent will be deployed in."
}

variable "replicas" {
  type        = number
  default     = 1
  description = "Number of replicas in the Kubernetes deployment"
}

variable "resource_limits_cpu" {
  type        = string
  default     = "1"
  description = "Kubernetes deployment resource hard CPU limit"
}

variable "resource_limits_memory" {
  type        = string
  default     = "512Mi"
  description = "Kubernetes deployment resource hard memory limit"
}

variable "resource_requests_cpu" {
  type        = string
  default     = "250m"
  description = "Kubernetes deployment resource CPU requests"
}

variable "resource_requests_memory" {
  type        = string
  default     = "50Mi"
  description = "Kubernetes deployment resource memory requests"
}

variable "service_account_annotations" {
  type        = map(string)
  default     = {}
  description = "Annotations to add to the Kubernetes service account"
}

variable "tags" {
  description = "Additional metadata tags."
  default     = {}
  type        = map(string)
}

variable "tfc_agent_log_level" {
  type        = string
  default     = "info"
  description = <<-EOF
    The log verbosity expressed as a level string. Level options include
    "trace", "debug", "info", "warn", and "error"
  EOF
}

variable "tfc_agent_data_dir" {
  type        = string
  default     = null
  description = <<-EOF
    The path to a directory to store all agent-related data, including
    Terraform configurations, cached Terraform release archives, etc. It is
    important to ensure that the given directory is backed by plentiful
    storage.
  EOF
}

variable "tfc_agent_name" {
  type        = string
  default     = null
  description = "The name of the Terraform Cloud Agent (will be displayed in the TFC console)."
}

variable "tfc_agent_single" {
  type        = bool
  default     = false
  description = <<-EOF
    Enable single mode. This causes the agent to handle at most one job and
    immediately exit thereafter. Useful for running agents as ephemeral
    containers, VMs, or other isolated contexts with a higher-level scheduler
    or process supervisor.
  EOF
}

variable "tfc_agent_disable_update" {
  type        = bool
  default     = false
  description = "Disable automatic core updates."
}

variable "tfc_address" {
  type        = string
  default     = "https://app.terraform.io"
  description = "The HTTP or HTTPS address of the Terraform Cloud API."
}

variable "tfc_organization_name" {
  type        = string
  default     = "whatnottfc"
  description = "The Terraform Cloud organization name."
}
