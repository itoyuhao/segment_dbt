import {
  to = segment_reverse_etl_model.id-pLcc3mUBhtbo8ncQ1xazfm
  id = "pLcc3mUBhtbo8ncQ1xazfm"
}

resource "segment_reverse_etl_model" "id-pLcc3mUBhtbo8ncQ1xazfm" {
  description             = " "
  enabled                 = true
  name                    = "purchases__valid"
  query                   = "SELECT \n  p.purchase_id, p.purchase_no, p.pay_type, p.total_amount, p.pay_amount, p.purchase_status, p.transaction_time, p.member_id as account_id, p.store_id , c.category\nFROM `jkopay-sit-data.data_silver.purchases__valid` p\nINNER JOIN `jkopay-sit-data.data_silver__DEV.stores__category_table` c\n  ON p.store_id = c.store_id\nWHERE p.transaction_time >= '2024-01-01'"
  query_identifier_column = "purchase_id"
  source_id               = "r8kYGBpjGYJe9Gh1wdoeLd"
}