defmodule ExTaxjar.SummaryRates do
  def list do
    {:ok, %{body: body}} = ExTaxjar.get("/summary_rates")
    body["summary_rates"]
  end
end
