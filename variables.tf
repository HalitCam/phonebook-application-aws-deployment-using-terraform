variable "project_name" {
  default = "phonebook-application"
}

variable "subnet_count" {
  default = 3
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "key_name" {
  default = "halit-key"
}

variable "git_token_parameter" {
  description = "Git token"
  default     = "/phonebook/github/token"
}

variable "instance_type" {
  default = "t3.small"
}
variable "hosted_zone_name" {
  default = "halitcloud.com"
}