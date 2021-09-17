# terraform-cwagent-ecs-instance-metric

<img width="1000" alt="logo" src="https://github.com/unfor19/terraform-cwagent-ecs-instance-metric/blob/master/assets/terraform-cwagent-ecs-instance-metric.png?raw=true" />


The terraform module for [deploying the CloudWatch Agent to Collect EC2 Instance-Level Metrics on Amazon ECS](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-ECS-instancelevel.html#deploy-container-insights-ECS-instancelevel-quickstart). The [original CloudFormation template](https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/ecs-task-definition-templates/deployment-mode/daemon-service/cwagent-ecs-instance-metric/cloudformation-quickstart/cwagent-ecs-instance-metric-cfn.json).

**IMPORTANT**: Works only on Linux EC2 instances. If you have 2 Linux + 1 Windows, then the ECS Service desired count will be 3, but the running tasks will be 2, which is normal.


## CloudWatch Agent Configuration

In a future release, it will be possible to set a [custom configuration for the CloudWatch Agent](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-ECS-instancelevel.html#:~:text=Advanced%20Configuration) with [SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html).

<details>

<summary>Default configuration file values - Expand/Collapse</summary>

- region (AWS Region)
- metrics_collection_interval (Seconds)
- force_flush_interval (Seconds)
- endpoint_override (Omitted)

```json
{
    "agent": {
        "region": "your-aws-region"
    },
    "logs": {
        "metrics_collected": {
            "ecs": {
                "metrics_collection_interval": 60
            }
        },
        "force_flush_interval": 5
    }
}
```

</details>

## Usage

```ruby
module "cwagent" {
  source       = "unfor19/ecs-instance-metric/cwagent"
  version      = "0.0.3"

  # required
  region       = "eu-west-1"
  cluster_name = "my-ecs-cluster-name"

  # optional
  prefix       = "ecs"
  app_name     = "cwagent"
  suffix       = "dev"
}
```

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
| app_name | Assigned to Resources Names | `string` | `"cwagent"` | no |
| cluster_name | Target ECS Cluster from which you want to collect metrics | `string` | n/a | yes |
| execution_role_arn | Target ECS Execution Role, if empty then the role is created as part of this module | `string` | `""` | no |
| image_tag | CloudWatch Agent Image Tag for amazon/cloudwatch-agent:{image_tag} | `string` | `"1.247347.3b250378"` | no |
| prefix | Prefix all resources with this string, example: myapp | `string` | `""` | no |
| region | Target region | `string` | n/a | yes |
| suffix | Suffix all resources with this string, example: dev | `string` | `""` | no |
| task_cpu | CloudWatch Agent Task milli-CPU | `number` | `128` | no |
| task_memory | CloudWatch Agent Task Memory (MB) | `number` | `64` | no |
| task_role_arn | Target ECS Task Role, if empty then the role is created as part of this module | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| app_name | App name, optionally includes prefix and suffix |
| ecs_service_arn | Service ARN |
| ecs_task_definition_arn | Task Definition ARN |
| iam_cwagent_task_execution_role_arn | Task Execution Role ARN |
| iam_cwagent_task_role_arn | Task Role ARN |

<!-- terraform_docs_end -->

## Authors

Created and maintained by [Meir Gabay](https://github.com/unfor19)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/unfor19/cwagent-ecs-instance-metric-terraform/blob/master/LICENSE) file for details

