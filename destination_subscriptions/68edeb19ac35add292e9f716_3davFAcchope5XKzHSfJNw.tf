import {
  to = segment_destination_subscription.id-68edeb19ac35add292e9f716_3davFAcchope5XKzHSfJNw
  id = "68edeb19ac35add292e9f716:3davFAcchope5XKzHSfJNw"
}

resource "segment_destination_subscription" "id-68edeb19ac35add292e9f716_3davFAcchope5XKzHSfJNw" {
  action_id      = "ujsJxBdpg7XkYwKSKREnQt"
  destination_id = "68edeb19ac35add292e9f716"
  enabled        = true
  model_id       = "83akv1YZnpDrgoRA3U9Hrd"
  name           = "user_tags_mapping"
  reverse_etl_schedule = {
    config   = null
    strategy = "MANUAL"
  }
  settings = jsonencode({
    consent = {
      "@path" = "$.context.consent"
    }
    engage_space = "IHhUjns8vZoMQv5MH7MrAbtwdPZJyVwl"
    event_name   = "Tag Code"
    message_id = {
      "@path" = "$.messageId"
    }
    properties = {
      "@path" = "$.properties"
    }
    timestamp = {
      "@path" = "$.receivedAt"
    }
    user_id = {
      "@path" = "$.properties.account_id"
    }
  })
  trigger = "event = \"new\" or event = \"updated\""
}