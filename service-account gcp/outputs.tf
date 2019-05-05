output "email" {
    value       = "${google_service_account.zver.email}"
    description = "The e-mail address of the service account."
}
output "name" {
    value       = "${google_service_account.zver.name}"
    description = "The fully-qualified name of the service account."
}
output "unique_id" {
    value       = "${google_service_account.zver.unique_id}"
    description = "The unique id of the service account."
}
