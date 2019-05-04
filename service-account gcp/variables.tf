variable "account_id" {
    description = "The service account ID. Changing this forces a new service account to be created."
    default     = "astral-root-234422"
}
variable "display_name" {
    description = "The display name for the service account. Can be updated without creating a new resource."
    default     = "sonickS"
}
variable "roles" {
    type        = "list"
    description = "The roles that will be granted to the account."
    default     = ["roles/cloudsql.admin"]
}
variable "project" {}