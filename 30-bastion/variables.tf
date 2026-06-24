variable  "project_name" {
  default = "expense"
}
variable "environment" {
   default =  "dev"
}
variable "common_tags" {
    type = map
    default = {
        Terraform = "true"
        Environment = "dev"
        Project = "expense"
    }
}
variable  "zone_id" {
  default = "Z012785114HGZTDQ8KSQH"
}