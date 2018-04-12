defmodule ExTaxjar.Order do
  @enforce_keys [:shipping, :to_country]
  use ExTaxjar.Order.Base, nexus_adresses: []
end
