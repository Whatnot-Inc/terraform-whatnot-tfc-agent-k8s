# TFC Agent Kubernetes

Deploys a Terraform Cloud Agent on an existing Kubernetes cluster. This agent
can be used to connect to and manager private resources with Terraform (i.e. 
connecting to our database directly from Terraform with the Postgresql 
provider).

## Usage

```hcl
provider "kubernetes" {
  # Context to choose from the config file, if needed.
  config_context = "example-context"
  version        = "~> 1.12"
}

module "tfc_agent" {
  source = "https://github.com/cloudposse/terraform-kubernetes-tfc-cloud-agent.git?ref=master"

  # Your agent token generated in Terraform Cloud
  token       = var.tfc_agent_token
  namespace   = var.namespace
  stage       = var.stage
  environment = var.environment
  name        = var.name

  # You can specify a namespace other than "default"
  kubernetes_namespace = "tfc-agent"
}
```

## Copyrights

Copyright © 2022 Whatnot, Inc.

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
