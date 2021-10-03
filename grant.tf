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

resource "auth0_client_grant" "grant" {
  for_each = {for item in local.clientGrantsByKey: item.key => item}

  client_id = auth0_client.client[each.value.client.name].client_id
  audience  = each.value.grant.audience
  scope     = each.value.grant.scopes
}
