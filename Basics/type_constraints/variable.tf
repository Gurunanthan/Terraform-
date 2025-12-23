# -------------------------------
# Instance count for non-prod
# -------------------------------
variable "instance_count_for_non_prod" {
    description = "Inform the instance count for the dev and qa"
    type        = number          # numeric value (count)
    default     = 1               # default to 1 instance
}

# -------------------------------
# Regions for non-prod deployment
# Using SET because:
# - order does not matter
# - duplicates are not allowed
# - good for for_each usage
# -------------------------------
variable "region_for_non_prod" {
    description = "region to be deployed in non prod"
    type        = set(string)
    default = [
        "us-east-1",
        "ap-northeast-3"
    ]
}

# -------------------------------
# Instance type for non-prod
# Single value → string
# -------------------------------
variable "instance_type_for_non_prod" {
    description = "Instance type for the non prod instance"
    type        = string
    default     = "t3.micro"
}

# -------------------------------
# Whether to delete EBS volume
# on instance termination
# -------------------------------
variable "delete_on_termination" {
    description = "Deleting the ebs on termination"
    type        = bool             # true / false flag
    default     = true
}

# -------------------------------
# AMI ID for EC2 instance
# Single AMI → string
# -------------------------------
variable "ami_id" {
    description = "Ubuntu ami id"
    type        = string
    default     = "ami-053e5b2b49d1b2a82"
}

# -------------------------------
# CIDR allow list for non-prod
# Using LIST because:
# - order may matter
# - index access is possible
# -------------------------------
variable "cidr_values_for_non_prod_instances" {
    description = "Multiple cidr values"
    type        = list(string)
    default = [
        "10.0.0.0/24",
        "11.0.0.0/24",
        "0.0.0.0/24"
    ]
}

# -------------------------------
# Tags for EC2 instance
# Using MAP for key → value pairs
# -------------------------------
variable "tags_for_ec2_instance" {
    description = "Tags to be added"
    type        = map(string)
    default = {
        Name   = "HelloWorld"
        Region = "ap-northeast-3"
    }
}

# -------------------------------
# NOTE:
# Variables cannot reference
# other variables directly
# -------------------------------

# -------------------------------
# Object (dictionary-like structure)
# Fixed schema with named fields
# -------------------------------
variable "template_for_instance_using_dict_aka_object" {
    type = {
        name                  = string
        type                  = string
        delete_on_termination = bool
        region                = string
        count                 = number
    }
    default = {
        name                  = "Instance name from dict aka object"
        type                  = "t3.micro"
        delete_on_termination = true
        region                = "ap-northeast-3"
        count                 = 2
    }
}

# -------------------------------
# Tuple example
# Fixed length and fixed types
# Index-based access:
# [0] → string
# [1] → bool
# [2] → number
# -------------------------------
variable "creating_variable_using_tuple" {
    type    = tuple([string, bool, number])
    default = ["", true, 1]
}
