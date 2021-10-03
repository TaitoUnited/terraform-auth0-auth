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

resource "auth0_resource_server" "api" {
  for_each    = {for item in local.apisByName: item.name => item}

  name                   = each.value.name
  identifier             = each.value.identifier
  signing_alg            = each.value.signingAlg
  signing_secret         = each.value.signingSecret

  allow_offline_access   = each.value.allowOfflineAccess
  token_lifetime         = each.value.tokenLifetime
  token_lifetime_for_web = each.value.tokenLifetimeForWeb

  verification_location  = each.value.verificationLocation
  options                = each.value.options
  enforce_policies       = each.value.enforcePolicies
  token_dialect          = each.value.tokenDialect

  skip_consent_for_verifiable_first_party_clients = each.value.skipConsentForVerifiableFirstPartyClients

  dynamic "scopes" {
    for_each = each.value.scopes != null ? each.value.scopes : []
    content {
      value = scopes.value.value
      description = scopes.value.description
    }
  }
}
