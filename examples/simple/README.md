# Simple Example
Webhook configuration
https://www.runatlantis.io/docs/configuring-webhooks.html

```terraform
module "terraform_gke_helm_atlantis" {
  source               = "getindata/terraform-gke-helm-atlantis"
  kubernetes_namespace = "default"
  name                 = "atlantis"
  project_id           = "example"

  values = [file("./extra-values/values.yaml")]  
  app = {
    name       = "atlantis"
}

```

## Usage
```
terraform init
terraform plan -out tfplan
terraform apply tfplan
```
