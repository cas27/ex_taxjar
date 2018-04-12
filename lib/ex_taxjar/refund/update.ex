defmodule ExTaxjar.Refund.Update do
  @enforce_keys [
    :transaction_id,
    :transaction_reference_id
  ]

  use ExTaxjar.Order.Base,
    transaction_id: nil,
    transaction_reference_id: nil,
    transaction_date: nil,
    sales_tax: nil
end
