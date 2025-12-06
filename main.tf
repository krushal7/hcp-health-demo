terraform {
  required_version = ">= 1.3.0"
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 2.0.0"
    }
  }
}

provider "http" {}

data "http" "current" {
  url = var.url
}

check "website_responds_200" {
  data "http" "current_check" {
    url = var.url
  }

  assert {
    condition     = data.http.current_check.status_code == 200
    error_message = "${var.url} returned status code ${data.http.current_check.status_code}"
  }
}

variable "url" {
  type    = string
  default = "https://www.terraform.io"
}
