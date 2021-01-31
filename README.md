# cwagent-ecs-instance-metric-terraform

The terraform module for [deploying the CloudWatch Agent to Collect EC2 Instance-Level Metrics on Amazon ECS](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-ECS-instancelevel.html#deploy-container-insights-ECS-instancelevel-quickstart). The [original CloudFormation template](https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/ecs-task-definition-templates/deployment-mode/daemon-service/cwagent-ecs-instance-metric/cloudformation-quickstart/cwagent-ecs-instance-metric-cfn.tpl).


<!-- terraform_docs_start -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.21 |
| aws | >= 2.68 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Enter the name of your ECS cluster from which you want to collect metrics | `string` | n/a | yes |
| execution_role_arn | Enter the role arn you want to use as the ecs execution role | `string` | `""` | no |
| image_tag | n/a | `string` | `"1.247347.3b250378"` | no |
| prefix | Prefix all resources with this string, example: myapp | `string` | `""` | no |
| region | Insert the region to deploy in, defaults to current region | `string` | n/a | yes |
| suffix | Suffix all resources with this string, example: dev | `string` | `""` | no |
| task_cpu | n/a | `number` | `128` | no |
| task_memory | n/a | `number` | `64` | no |
| task_role_arn | Enter the role arn you want to use as the ecs task role | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app_name | Final name of the app, optionally includes prefix and suffix |
| cwagent_task_role | Task role ARN |
| ecs_service_arn | Service ARN |
| ecs_task_definition_arn | Task definition ARN |
| iam_cwagent_task_execution_role | Task execution role ARN |

<!-- terraform_docs_end -->

## Authors

Created and maintained by [Meir Gabay](https://github.com/unfor19)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/unfor19/cwagent-ecs-instance-metric-terraform/blob/master/LICENSE) file for details

