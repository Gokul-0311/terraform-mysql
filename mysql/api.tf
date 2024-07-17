resource "google_project_service" "cloudsql" {
  service = "cloudsql.googleapis.com"
}