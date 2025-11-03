import {
  to = segment_reverse_etl_model.id-rypFU8n1z8FERVFB8qFCEJ
  id = "rypFU8n1z8FERVFB8qFCEJ"
}

resource "segment_reverse_etl_model" "id-rypFU8n1z8FERVFB8qFCEJ" {
  description             = "account_condition_record"
  enabled                 = true
  name                    = "account_condition_record"
  query                   = "SELECT id, account_id FROM data_bronze.jkopay__jkopay_account_condition_record__scd1\nWHERE _processed_at >= '2025-01-01'"
  query_identifier_column = "id"
  source_id               = "r8kYGBpjGYJe9Gh1wdoeLd"
}