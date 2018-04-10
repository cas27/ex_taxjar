defmodule ExTaxjar.Taxes do
  def tax(order) do
    {:ok, %{body: body}} =
      ExTaxjar.post("/taxes", JSX.encode!(order), [{"Content-Type", "application/json"}])

    body["tax"]
  end
end
