# Auth0 auth

Provides simple Auth0 authentication in a developer friendly and provider agnostic YAML format.

Example usage:

```
provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

module "auth" {
  source              = "TaitoUnited/auth/auth0"
  version             = "0.0.1"
  configuration       = yamldecode(file("${path.root}/../infra.yaml"))["auth"]
}
```

Example YAML:

```
# See variables.tf for more options
auth:
  tenant:
    name: IAQ
    logoUrl:
    supportEmail: support@mydomain.com
    supportUrl:

  clients:
    - name: client
      type: spa
      oidcConformant: true
      webOrigins:
        - https://my-project-dev.mydomain.com
      callbackUrls:
        - https://my-project-dev.mydomain.com/admin
    - name: server
      type: non_interactive

  connections:
    - name: auth0-database
      strategy: auth0
      options:
        passwordPolicy: good
        bruteForceProtection: true
      clients:
        - client
        - server
```

Similar provider agnostic YAML format is used also by the following modules:

- [AWS project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/aws)
- [Azure project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/azurerm)
- [Google Cloud project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/google)
- [Digital Ocean project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/digitalocean)
- [Full-stack template (Helm chart for Kubernetes)](https://github.com/TaitoUnited/taito-charts/tree/master/full-stack)

> TIP: This module is used by [project templates](https://taitounited.github.io/taito-cli/templates/#project-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/). See the [full-stack-template](https://github.com/TaitoUnited/full-stack-template) as an example on how to use this module.

Contributions are welcome! This module should include support for the most commonly used Azure services. For more specific cases, the YAML can be extended with additional Terraform modules.
