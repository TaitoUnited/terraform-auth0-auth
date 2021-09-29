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

resource "auth0_client" "client" {
  for_each = {for item in local.clientsByName: item.name => item}

  name = each.value.name
  description = each.value.description
  app_type = each.value.type
  custom_login_page_on = each.value.customLoginPageOn
  is_first_party = each.value.isFirstParty
  is_token_endpoint_ip_header_trusted = each.value.isTokenEndpointIpHeaderTrusted
  token_endpoint_auth_method = each.value.tokenEndpointAuthMethod
  oidc_conformant = each.value.oidcConformant
  callbacks = each.value.callbackUrls
  allowed_origins = each.value.origins
  grant_types = each.value.grantTypes
  allowed_logout_urls = each.value.logoutUrls
  web_origins = each.value.webOrigins

  dynamic "jwt_configuration" {
    for_each = each.value.jsonWebTokens != null ? [ each.value.jsonWebTokens ] : []
    content {
      lifetime_in_seconds = each.value.lifetimeInSeconds
      secret_encoded = each.value.secretEncoded
      alg = each.value.alg
      /* TODO: scopes
      scopes = {
        foo = "bar"
      }
      */
    }
  }

  dynamic "refresh_token" {
    for_each = each.value.refreshTokens != null ? [ each.value.refreshTokens ] : []
    content {
      rotation_type = each.value.rotationType
      expiration_type = each.value.expirationType
      leeway = each.value.leeway
      token_lifetime = each.value.tokenLifetime
      infinite_idle_token_lifetime = each.value.infiniteIdleTokenLifetime
      infinite_token_lifetime      = each.value.infiniteTokenLifetime
      idle_token_lifetime          = each.value.idleTokenLifetime
    }
  }

  /* TODO: client_metadata
  client_metadata = {
    foo = "zoo"
  }
  */

  /* TODO: addons
  addons {
    firebase = {
      client_email = "john.doe@example.com"
      lifetime_in_seconds = 1
      private_key = "wer"
      private_key_id = "qwreerwerwe"
    }
    samlp {
      audience = "https://example.com/saml"
      mappings = {
        email = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
        name = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
      }
      create_upn_claim = false
      passthrough_claims_with_no_mapping = false
      map_unknown_claims_as_is = false
      map_identities = false
      name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"
      name_identifier_probes = [
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
      ]
    }
  }
  */

  /* TODO: mobile
  mobile {
    ios {
      team_id = "9JA89QQLNQ"
      app_bundle_identifier = "com.my.bundle.id"
    }
  }
  */
}
