variable "user_names" {
  description = "Create IAM users"
  type        = list(string)
  default     = ["luca", "hp_lovecraft", "erich_zann"]
}
