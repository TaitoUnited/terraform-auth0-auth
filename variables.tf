/**
 * Copyright 2021 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "configuration" {
  type = object({

    // Tenant
    // See: https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/tenant
    tenant = optional(object({
      name = optional(string)
      logoUrl = optional(string)
      supportEmail = optional(string)
      supportUrl = optional(string)
      customDomains = optional(list(object({
        domain = string
        type = optional(string)
        verificationMethod = optional(string)
      })))

      // TODO: more settings
    }))

    // Brand
    // See: https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/branding
    brand = optional(object({
      faviconUrl = optional(string)
      logoUrl = optional(string)
      fontUrl = optional(string)
      primaryColor = optional(string)
      backgroundColor = optional(string)
      loginPageHtml = optional(string)
    }))

    // APIs
    // See: https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/resource_server
    apis = list(object({
      name = string
      identifier = string
      signingAlg = optional(string)
      signingSecret = optional(string)

      allowOfflineAccess = optional(bool)
      tokenLifetime = optional(number)
      tokenLifetimeForWeb = optional(number)

      verificationLocation = optional(string)
      options = optional(map(string))
      enforcePolicies = optional(bool)
      tokenDialect = optional(string)

      skipConsentForVerifiableFirstPartyClients = optional(bool)

      scopes = optional(list(object({
        value = string
        description = optional(string)
      })))
    }))

    // Clients
    // See: https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/client
    clients = list(object({

      // Provider agnostic options (TODO: add more)
      name = string
      description = optional(string)
      type = string
      oidcConformant = optional(bool)
      callbackUrls = optional(list(string))
      logoutUrls = optional(list(string))
      webOrigins = optional(list(string))
      origins = optional(list(string))

      jsonWebTokens = optional(list(object({
        lifetimeInSeconds = number
        secretEncoded = bool
        alg = string
        // TODO: scopes
      })))

      refreshTokens = optional(list(object({
        rotationType = string
        expirationType = string
        leeway = number
        infiniteTokenLifetime = bool
        tokenLifetime = number
        infiniteIdleTokenLifetime = bool
        idleTokenLifetime = number
      })))

      grants = optional(list(object({
        audience = string
        scopes = optional(list(string))
      })))

      // Auth0 specific options (TODO: add more)
      grantTypes = optional(list(string))
      customLoginPageOn = optional(bool)
      isFirstParty = optional(bool)
      isTokenEndpointIpHeaderTrusted = optional(bool)
      tokenEndpointAuthMethod = optional(string)
    }))

    // Connections
    // See: https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/connection
    connections = list(object({
      name = string
      strategy = string
      isDomainConnection = optional(bool)
      clients = optional(list(string))
      realms = optional(list(string))
      options = optional(object({
        passwordPolicy = optional(string)
        bruteForceProtection = optional(bool)
        disableSignup = optional(bool)
        // TODO: more options
      }))
    }))
  })
  description = "Configuration as JSON (see README.md). You can read values from a YAML file with yamldecode()."
}
