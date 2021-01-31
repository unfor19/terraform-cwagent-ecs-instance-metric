output "aws_ecs_service_arn" {
  value       = aws_ecs_service.cwagent.arn
  description = "Service ARN"
}
