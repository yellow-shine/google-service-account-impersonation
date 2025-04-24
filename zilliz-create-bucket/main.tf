terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  # zilliz service account key
  credentials = file("zilliz-service-account-key.json")

  # impersonate customer service account
  impersonate_service_account = "customer-service-account@zilliz-byoc-user-prj1.iam.gserviceaccount.com" 
}

# Create a bucket in customer project
resource "google_storage_bucket" "bucket" {
  project  = "zilliz-byoc-user-prj1" # Target Project A
  name     = "milvus-bucket-created-by-zilliz-xx" # Globally unique name
  location = "US"
}