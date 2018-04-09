defmodule ExTaxjar.Categories do
  def list do
    {:ok, %{body: body}} = ExTaxjar.get("/categories")
    body["categories"]
  end
end
