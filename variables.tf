variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]

}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "wordpress"
}

variable "db_user" {
  description = "Name of the database user"
  type        = string
  default     = "wordpress"
}

variable "db_password" {
  description = "Password of the database user"
  type        = string
  default     = "wordpress"
}
variable "ami_id" {
  description = "AMI ID for the WordPress server"
  type        = string
  default     = "ami-0322211ccfe5b6a20"
}