variable "name" {
  description = "Name of Log Analystics Workspace."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "sku" {
  description = "Specified the Sku of the Log Analytics Workspace."
  default     = "PerNode"
}


variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}