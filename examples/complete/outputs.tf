output "terraform_gke_helm_release" {
  value       = module.terraform_helm_atlantis.terraform_gke_helm_release
  description = "Terraform gke helm release module outputs"
}
