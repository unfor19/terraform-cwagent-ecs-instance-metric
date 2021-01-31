### Task Execution role
data "template_file" "cwagent_task_execution_role_policy" {
  template = file("${path.module}/templates/iam-task-execution-role-policy.tpl")
}


resource "aws_iam_role" "cwagent_task_execution_role" {
  count              = local.create_iam_task_role
  name               = "CWAgentECSExecutionRole"
  assume_role_policy = data.template_file.cwagent_task_execution_role_policy.rendered
}


resource "aws_iam_role_policy_attachment" "cwagent_task_role_managed_policy1" {
  role       = aws_iam_role.cwagent_task_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


resource "aws_iam_role_policy_attachment" "cwagent_task_role_managed_policy2" {
  role       = aws_iam_role.cwagent_task_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


### Task Role
data "template_file" "cwagent_task_role_policy" {
  template = file("${path.module}/templates/iam-task-role-policy.tpl")
}


resource "aws_iam_role" "cwagent_task_role" {
  count              = local.create_iam_task_execution_role
  name               = "CWAgentECSTaskRole"
  assume_role_policy = data.template_file.cwagent_task_role_policy.rendered
}


resource "aws_iam_role_policy_attachment" "cwagent_task_execution_role_managed_policy" {
  role       = aws_iam_role.cwagent_task_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
