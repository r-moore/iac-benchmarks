# Comparing Infrastructure as Code (IaC) tools

## Tools compared

- [Architect](https://arc.codes)
- [CDK](https://aws.amazon.com/cdk/)
- [CDKTF](https://cdk.tf/) (CDK for Terraform)
- [CloudFormation](https://aws.amazon.com/cloudformation/)
- [Terraform](https://developer.hashicorp.com/terraform)
- [Pulumi](https://www.pulumi.com/)
- [SST](https://sst.dev/) (version 3)
- [Serverless Framework](https://www.serverless.com/) (version 4)

Some of these tools are built on top of others (such as SST using Pulumi, and CDKTF using Terraform) but I still believe there is value in comparing them.

## Benchmarks

Benchmarks are run against AWS (eu-west-1), measuring the relative speed of a sample deployment.
Where possible I will benchmark against a [LocalStack](https://localstack.cloud/) instance too.

Many of the tools support multiple ways of storing deployment state. In these cases will benchmark S3, file-based, and the vendor's proprietary cloud backends. This choice can greatly affect performance.

Some of the tools support multiple ways of deploying a same stack to AWS. For example, Pulumi supports a "Classic" AWS provider (calling individual AWS service APIs) and a newer "Native" AWS provider (calling the consolidated AWS Cloud Control API). In these cases I will compare both.

I will deploy a sample application using each tool:

- S3 bucket
- DynamoDB table
- Lambda function connected to DynamoDB stream event source
- IAM role for the above Lambda function

## Features & Developer Experience

All code samples are written in TypeScript.

I will also compare:

- Project maturity
- Community size
- Documentation
- IDE autocompletion via TypeScript
- Active development & support for latest AWS features
- Ability to support offline development (LocalStack)
- Verbosity of deployment templates
- Automation capabilities, integration with CI/CD pipelines (e.g. GitHub Actions)
- Secrets management capabilities
- Support for modern TypeScript runtimes (e.g. Bun)
- Built-in bundler for TypeScript lambda functions (e.g. esbuild)
- Support for hot-reloading changes during development of Lambda functions
- Licensing and costs

## Known Issues

There is a compatibility issue with the latest versions of terraform and LocalStack, affecting several of the tools in this repository when trying to deploy a DynamoDB table (see github issues [#13140](https://github.com/localstack/localstack/issues/13140) [#13155](https://github.com/localstack/localstack/issues/13155)). The workaround is to use an older version of the terraform provider.

## Contributions

Please let me know if I've made an unfair comparison, missed an optimization, or just got something wrong.

I will gratefully accept contributions to this project.
