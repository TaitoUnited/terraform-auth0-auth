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

locals {
  tenant = try(var.configuration.tenant, {})

  brand = try(var.configuration.brand, {})

  customDomains = (
    local.tenant.customDomains != null ? local.tenant.customDomains : []
  )

  apisByName = {
    for api in var.configuration.apis:
    api.name => api
  }

  clientsByName = {
    for client in var.configuration.clients:
    client.name => client
  }

  clientGrantsByKey = {
    for item in flatten([
      for client in var.configuration.clients: [
        for grant in (client.grants != null ? client.grants : []):
        {
          key    = "${client.name}-${grant.audience}"
          client = client
          grant  = grant
        }
      ]
    ]):
    item.key => item
  }

  connectionsByName = {
    for connection in var.configuration.connections:
    connection.name => connection
  }
}
