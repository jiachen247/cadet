variable "env" {
  description = "Environment Identifier"
}

variable "ami_id" {
  description = "AMI ID to be used"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
}

variable "rds_instance_class" {
  description = "RDS Instance Class"
}

variable "min_instance_count" {
  description = "Min. Number of Instance"
}

variable "max_instance_count" {
  description = "Max. Number of Instance"
}

variable "rds_allocated_storage" {
  description = "Allocated Storage for RDS"
}

variable "rds_password" {
  description = "Password for RDS"
}

variable "lambda_filename" {
  description = "Location of the lambda deployment zip"
}

variable "lambda_timeout" {
  description = "Timeout duration of the lambda service (seconds)"
}

variable "grader_timeout" {
  description = "TIMEOUT_DURATION of the grader (milliseconds)"
}

variable "ssh_public_key" {
  description = "Public SSH Key Used by the Instance"
}
