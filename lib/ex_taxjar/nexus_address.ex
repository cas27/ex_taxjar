defmodule ExTaxjar.NexusAddress do
  @enforce_keys [:country, :zip, :state]
  defstruct(
    id: nil,
    country: nil,
    zip: nil,
    state: nil,
    city: nil,
    street: nil
  )
end
