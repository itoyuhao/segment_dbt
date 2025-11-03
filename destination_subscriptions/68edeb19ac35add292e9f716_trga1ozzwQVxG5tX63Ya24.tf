import {
  to = segment_destination_subscription.id-68edeb19ac35add292e9f716_trga1ozzwQVxG5tX63Ya24
  id = "68edeb19ac35add292e9f716:trga1ozzwQVxG5tX63Ya24"
}

resource "segment_destination_subscription" "id-68edeb19ac35add292e9f716_trga1ozzwQVxG5tX63Ya24" {
  action_id      = "ujsJxBdpg7XkYwKSKREnQt"
  destination_id = "68edeb19ac35add292e9f716"
  enabled        = true
  model_id       = "pLcc3mUBhtbo8ncQ1xazfm"
  name           = "txn_detail_mapping"
  reverse_etl_schedule = {
    config   = null
    strategy = "MANUAL"
  }
  settings = jsonencode({
    consent = {
      "@path" = "$.context.consent"
    }
    engage_space = "IHhUjns8vZoMQv5MH7MrAbtwdPZJyVwl"
    event_name   = "Order completed"
    message_id = {
      "@path" = "$.messageId"
    }
    properties = {
      "@path" = "$.properties"
    }
    timestamp = {
      "@path" = "$.properties.transaction_time"
    }
    user_id = {
      "@path" = "$.properties.account_id"
    }
  })
  trigger = "event = \"new\" or event = \"updated\""
}