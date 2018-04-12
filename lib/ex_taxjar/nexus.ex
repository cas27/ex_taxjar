defmodule ExTaxjar.Nexus do
  def list do
    {:ok, %{body: body}} = ExTaxjar.get("/nexus/regions")
    body["regions"]
  end
end
