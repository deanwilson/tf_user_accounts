variable "group_name" {
    description = "Group name to collect provided users under"
}

variable "group_iam_path" {
    description = "IAM path to create the group under"
    default = "/"
}

variable "policy_document_arn" {
    description = "The policy ARN to attach to this group"
}

variable "user_iam_path" {
    description = "IAM path to create the user accounts under"
    default = "/"
}

variable "user_names" {
    description = "A CSV containing the users to create and place in 'group_name'"
}
