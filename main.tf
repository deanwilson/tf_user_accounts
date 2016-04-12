resource "aws_iam_group" "group" {
    name = "${var.group_name}"
    path = "${var.group_iam_path}"
}


resource "aws_iam_user" "user" {
    count = "${length(split(",", var.user_names))}"
    name  = "${element(split(",", var.user_names), count.index)}"
}


resource "aws_iam_group_membership" "membership" {
    name = "${var.group_name}-group-membership"
    users = [
        "${split(",", var.user_names)}"
    ]
    group = "${aws_iam_group.group.name}"
}

resource "aws_iam_policy_attachment" "policy_attachment" {
    name = "${var.group_name}-policy"
    groups = ["${aws_iam_group.group.name}"]
    policy_arn = "${var.policy_document_arn}"
}
