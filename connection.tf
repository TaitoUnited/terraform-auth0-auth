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

resource "auth0_connection" "connection" {
  for_each = {for item in local.connectionsByName: item.name => item}

  name = each.value.name
  strategy = each.value.strategy
  is_domain_connection = each.value.isDomainConnection

  enabled_clients = flatten(concat([
    for name in coalesce(each.value.clients, []):
    auth0_client.client[name].client_id
  ], [
    for client in local.clientsById: (
      contains(coalesce(client.connections, []), each.value.name)
        ? [ auth0_client.client[client.id].client_id ]
        : []
    )
  ]))

  realms = each.value.realms

  dynamic "options" {
    for_each = each.value.options != null ? [ each.value.options ] : []
    content {
      password_policy = options.value.passwordPolicy
      brute_force_protection = options.value.bruteForceProtection
      disable_signup = options.value.disableSignup
    }
  }
}
