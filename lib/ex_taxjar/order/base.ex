defmodule ExTaxjar.Order.Base do
  @base_fields [
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
    line_items: []
  ]

  defmacro __using__(fields) do
    fields = @base_fields ++ fields

    quote do
      defstruct(unquote(fields))
    end
  end
end
