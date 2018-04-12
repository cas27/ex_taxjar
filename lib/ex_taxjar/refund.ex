defmodule ExTaxjar.Refund do
  @enforce_keys [
    :shipping,
    :sales_tax,
    :amount,
    :transaction_id,
    :transaction_reference_id,
    :transaction_date,
    :to_country,
    :to_zip,
    :to_state
  ]

  use ExTaxjar.Order.Base,
    transaction_id: nil,
    transaction_reference_id: nil,
    transaction_date: nil,
    sales_tax: nil
end
