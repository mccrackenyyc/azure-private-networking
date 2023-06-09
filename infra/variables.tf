variable "subscription_id" {
  description = "Azure subscription"
  type        = string
  default     = "20c17ce1-c880-4374-ab18-0c3a72158cf7"
}

variable "env_name" {
  description = "Working environment"
  type        = string
  default     = "dev"
}

variable "exampletag" {
  description = "Example use of a tag"
  type        = string
  default     = "exampletag"
}