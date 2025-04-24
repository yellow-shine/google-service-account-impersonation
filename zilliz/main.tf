terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  project = "vdc-dev-test" # zilliz project
}

# Create a service account in zilliz project
resource "google_service_account" "zilliz" {
  account_id   = "zilliz"
}

# Create a key for the service account
resource "google_service_account_key" "zilliz_key" {
  service_account_id = google_service_account.zilliz.name
}

# Generate the key JSON file
resource "local_file" "service_account_key" {
  content  = base64decode(google_service_account_key.zilliz_key.private_key)
  filename = "${path.module}/../zilliz-create-bucket/zilliz-service-account-key.json"
}

output "service_account" {
  value = google_service_account.zilliz.email
}
