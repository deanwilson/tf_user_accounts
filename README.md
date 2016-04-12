# User Accounts Terraform Module

## Introduction

This module takes a simplistic approach to adding a set of users and
placing them inside a given group. It can be used mutiple times as long
as the usernames are not repeated across multiple groups. In the model
every user belongs to one group.

When using the module it actually follows these steps:

  * creates the group named `group_name`
  * assigns a policy (referenced in `policy_document_arn`) to the group
  * creates all the users given in `user_names`
  * makes them all members of the created group

## Usage

To use the module in your terraform files there are two steps. Firstly
you need a policy document Amazon Resource Name (ARN) from the policy
you want attached to the group, and to all the users in it, and then you
define a `module` resource that passes it to the user creation steps. An
example of this can be seen below.

    # here we create a default access everything policy
    resource "aws_iam_policy" "admin_policy" {
        name = "admin-policy"
        description = "Admin policy: full access"
        policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "*",
          "Resource": "*"
        }
      ]
    }
    EOF
    }

    # here we use the module to create an admin group and two users
    module "admins" {
        source = "github.com/deanwilson/tf_user_accounts"

        group_name = "admins"
        group_iam_path = "/admins/"

        # and here we use the ARN from the policy we created above.
        policy_document_arn = "${aws_iam_policy.admin_policy.arn}"

        user_iam_path = "/users/"
        user_names = "mctesty01,mctesty02"
    }


### Module Input Variables

 * `group_name`
  * The name of the group to create and add users from `user_names` to

 * `group_iam_path`
  * IAM path to create the group in
  * defaults to `/`

 * `policy_document_arn`
  * ARN of the policy to attach to this group


 * `user_iam_path`
  * IAM path to create the user accounts in
  * defaults to `/`

 * `user_names`
  * A comma seperated string containing the usernames to create and place in `group_name`

### Module Outputs

  * `group_name` - the name of the group we created.

### Limitations

When creating them using this module users can only be in one group.

#### Author
[Dean Wilson](http://www.unixdaemon.net)
