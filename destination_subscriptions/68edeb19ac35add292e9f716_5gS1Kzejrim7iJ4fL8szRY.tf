import {
  to = segment_destination_subscription.id-68edeb19ac35add292e9f716_5gS1Kzejrim7iJ4fL8szRY
  id = "68edeb19ac35add292e9f716:5gS1Kzejrim7iJ4fL8szRY"
}

resource "segment_destination_subscription" "id-68edeb19ac35add292e9f716_5gS1Kzejrim7iJ4fL8szRY" {
  action_id      = "vm2tNA5U1zxUusQkdC4D7Z"
  destination_id = "68edeb19ac35add292e9f716"
  enabled        = true
  model_id       = "83akv1YZnpDrgoRA3U9Hrd"
  name           = "account_tag_mapping"
  reverse_etl_schedule = {
    config   = null
    strategy = "MANUAL"
  }
  settings = jsonencode({
    consent = {
      "@path" = "$.context.consent"
    }
    engage_space = "IHhUjns8vZoMQv5MH7MrAbtwdPZJyVwl"
    message_id = {
      "@path" = "$.messageId"
    }
    timestamp = {
      "@path" = "$.receivedAt"
    }
    traits = {
      "@path" = "$.properties"
    }
    user_id = {
      "@path" = "$.properties.account_id"
    }
  })
  trigger = "event = \"new\" or event = \"updated\" or event = \"deleted\""
}