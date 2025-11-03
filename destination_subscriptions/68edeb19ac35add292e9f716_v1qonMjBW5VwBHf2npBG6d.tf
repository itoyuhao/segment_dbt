import {
  to = segment_destination_subscription.id-68edeb19ac35add292e9f716_v1qonMjBW5VwBHf2npBG6d
  id = "68edeb19ac35add292e9f716:v1qonMjBW5VwBHf2npBG6d"
}

resource "segment_destination_subscription" "id-68edeb19ac35add292e9f716_v1qonMjBW5VwBHf2npBG6d" {
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
    event_name   = "Order Completed"
    message_id = {
      "@path" = "$.messageId"
    }
    properties = {
      pay_amount = {
        "@path" = "$.properties.pay_amount"
      }
      pay_type = {
        "@path" = "$.properties.pay_type"
      }
      purchase_no = {
        "@path" = "$.properties.purchase_no"
      }
      purchase_status = {
        "@path" = "$.properties.purchase_status"
      }
      total_amount = {
        "@path" = "$.properties.total_amount"
      }
      transaction_time = {
        "@path" = "$.properties.transaction_time"
      }
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