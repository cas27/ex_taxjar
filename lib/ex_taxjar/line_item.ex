defmodule ExTaxjar.LineItem do
  defstruct(
    id: nil,
    quantity: nil,
    product_tax_code: nil,
    unit_price: nil,
    discount: nil
  )
end
