defmodule ExTaxjar.Rates do
  def rate(zip) do
    {:ok, %{body: body}} = ExTaxjar.get("/rates/#{zip}")
    body["rate"]
  end

  def rate(zip, params) do
    {:ok, %{body: body}} = ExTaxjar.get("/rates/#{zip}", [], params: params)
    body["rate"]
  end
end
