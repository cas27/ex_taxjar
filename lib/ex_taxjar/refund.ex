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

  defstruct(
    transaction_id: nil,
    transaction_reference_id: nil,
    transaction_date: nil,
    from_country: nil,
    from_zip: nil,
    from_state: nil,
    from_city: nil,
    from_street: nil,
    to_country: nil,
    to_zip: nil,
    to_state: nil,
    to_city: nil,
    to_street: nil,
    amount: nil,
    shipping: nil,
    sales_tax: nil,
    line_items: []
  )
end
