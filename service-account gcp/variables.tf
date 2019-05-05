variable "account_id" {
    description = "The service account ID. Changing this forces a new service account to be created."
    default     = "civil-celerity-239622"
}
variable "display_name" {
    description = "The display name for the service account. Can be updated without creating a new resource."
    default     = "My First Project"
}
variable "roles" {
    type        = "list"
    description = "Provides access to full management of Container Clusters and their Kubernetes API objects."
    default     = ["roles/container.admin",]
}
variable "project" {}