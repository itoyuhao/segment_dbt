import {
  to = segment_destination_subscription.id-68edeb19ac35add292e9f716_bXXnj85cpSHauCWBtc9qGJ
  id = "68edeb19ac35add292e9f716:bXXnj85cpSHauCWBtc9qGJ"
}

resource "segment_destination_subscription" "id-68edeb19ac35add292e9f716_bXXnj85cpSHauCWBtc9qGJ" {
  action_id      = "vm2tNA5U1zxUusQkdC4D7Z"
  destination_id = "68edeb19ac35add292e9f716"
  enabled        = true
  model_id       = "wXwpkdESg5yzYYizLtXSuw"
  name           = "account_detail_mapping"
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
      create_time = {
        "@path" = "$.properties.create_time"
      }
      jkos_id = {
        "@path" = "$.properties.jkosid"
      }
      jkosaccount = {
        "@path" = "$.properties.jkos_account"
      }
    }
    user_id = {
      "@path" = "$.properties.account_id"
    }
  })
  trigger = "event = \"new\" or event = \"updated\" or event = \"deleted\""
}