defmodule ExTaxjar.Transaction.Update do
  @enforce_keys [
    :transaction_id
  ]

  use ExTaxjar.Order.Base,
    transaction_id: nil,
    transaction_date: nil,
    sales_tax: nil
end
