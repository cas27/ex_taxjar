defmodule ExTaxjar.Validations do
  def validate(vat) do
    {:ok, %{body: body}} = ExTaxjar.get("/validation", [], params: %{vat: vat})
    body["validation"]
  end
end
