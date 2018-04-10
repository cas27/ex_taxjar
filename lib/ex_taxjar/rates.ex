defmodule ExTaxjar.Rates do
  def rate(zip, options \\ []) do
    {:ok, %{body: body}} = ExTaxjar.get("/rates/#{zip}", [], options)
    body["rate"]
  end
end
