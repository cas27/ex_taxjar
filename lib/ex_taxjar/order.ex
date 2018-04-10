defmodule ExTaxjar.Order do
  @enforce_keys [:shipping, :to_country]

  defstruct(
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
    shipping: nil
  )
end
