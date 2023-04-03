# variable "bucket_name" {
#   description = "S3 bucket name"
#   type        = string
# }

variable "endpoint" {
  description = "Endpoint url"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "db_name"{
  description = "The database name"
}
variable "db_pass"{
    description = "The database password"
}

variable "db_user"{
  description = "The database user"
  
}