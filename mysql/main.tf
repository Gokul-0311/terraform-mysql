resource "google_sql_database_instance" "primarydb" {
  name = "my_sql_db"
  region = "var.region"
  database_version = "MYSQL_8_0"

  settings {
    tier = "var.instance_type"
    disk_size = "var.disk_size"
    availability_type = "REGIONAL"
  }
  deletion_protection = "false"
}

resource "google_sql_database" "sql_database" {
  name = "my_sql_database"
  instance = "google_sql_database_instance.primarydb.name"
  
}

resource "random_string" "random" {
  length = "12"
  special = "false"
}

resource "google_sql_user" "sqluser" {
  name = "my_sql_user"
  instance = "google_sql_database_instance.primarydb.name"
  password = "random_string.random.name"
}

resource "google_sql_database_instance" "replica" {
  name = "my_replica"
  master_instance_name = "google_sql_database_instance.primarydb.name"
  database_version = "MYSQL_8_0"
  region = "var.region"

  settings {
    tier = "var.instance_type"
    disk_size = "var.replica.disk_size"
    availability_type = "REGIONAL"
  }
  deletion_protection = "false"

  depends_on = [ google_sql_database_instance.primarydb ]
}

