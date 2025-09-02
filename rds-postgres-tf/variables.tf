variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "assume_role_arn" {
  description = "ARN of the role to assume"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "The instance type for the RDS instance"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
  default     = 50
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}