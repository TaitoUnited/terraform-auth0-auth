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
    applications = list(object({

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

      // Auth0 specigic options (TODO: add more)
      grantTypes = optional(list(string))
      customLoginPageOn = optional(bool)
      isFirstParty = optional(bool)
      isTokenEndpointIpHeaderTrusted = optional(bool)
      tokenEndpointAuthMethod = optional(string)
    }))
  })
  description = "Configuration as JSON (see README.md). You can read values from a YAML file with yamldecode()."
}
