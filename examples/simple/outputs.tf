output "gcp_service_account" {
  value = module.terraform_helm_atlantis.gcp_service_account
}
output "gcp_service_account_email" {
  value       = module.terraform_helm_atlantis.gcp_service_account_email
  description = "Email address of GCP service account."
}
output "gcp_service_account_fqn" {
  value       = module.terraform_helm_atlantis.gcp_service_account_fqn
  description = "FQN of GCP service account."
}
output "gcp_service_account_name" {
  value       = module.terraform_helm_atlantis.gcp_service_account_name
  description = "Name of GCP service account."
}
output "k8s_service_account_name" {
  value       = module.terraform_helm_atlantis.k8s_service_account_name
  description = "Name of K8S service account."
}
output "k8s_service_account_namespace" {
  value       = module.terraform_helm_atlantis.k8s_service_account_namespace
  description = "Namespace of k8s service account."
}
