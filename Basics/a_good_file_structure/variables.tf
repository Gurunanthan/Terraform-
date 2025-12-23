variable "primary_region" {
  description = "Primary AWS region"
  type        = string
  default     = "ap-northeast-3"
}

variable "instance_count_for_non_prod" {
  description = "Number of EC2 instances for non-prod"
  type        = number
  default     = 1
}

variable "instance_type_for_non_prod" {
  description = "Instance type for non-prod"
  type        = string
  default     = "t3.micro"
}

variable "delete_on_termination" {
  description = "Delete root EBS volume on termination"
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "cidr_values_for_non_prod_instances" {
  description = "Allowed CIDR blocks"
  type        = list(string)
}

variable "tags_for_ec2_instance" {
  description = "Tags for EC2"
  type        = map(string)
}
