output "app_name" {
  value       = local.app_name
  description = "App name, optionally includes prefix and suffix"
}

output "ecs_service_arn" {
  value       = aws_ecs_service.cwagent.arn
  description = "Service ARN"
}

output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.cwagent.ARN
  description = "Task Definition ARN"
}

output "iam_cwagent_task_execution_role" {
  value       = aws_iam_role.cwagent_task_execution_role.arn
  description = "Task Execution Role ARN"
}

output "iam_cwagent_task_role" {
  value       = aws_iam_role.cwagent_task_role.arn
  description = "Task Role ARN"
}
