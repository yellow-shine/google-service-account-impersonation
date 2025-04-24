terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

variable "delegate_from" {
  type = string
  description = "The service account that can impersonate the customer service account"
}

provider "google" {
  project = "zilliz-byoc-user-prj1" # customer project
}

# Create a service account in customer project
resource "google_service_account" "customer_service_account" {
  account_id   = "customer-service-account"
  display_name = "Customer Service Account"
}

# Allow customer service account to access storage
resource "google_project_iam_member" "storage_admin_role_binding" {
  project = "zilliz-byoc-user-prj1"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.customer_service_account.email}"
}


# Allow zilliz service account to impersonate customer service account
resource "google_service_account_iam_binding" "impersonate" {
  service_account_id = google_service_account.customer_service_account.name
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "serviceAccount:${var.delegate_from}"
  ]

}
