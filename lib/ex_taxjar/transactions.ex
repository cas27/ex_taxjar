defmodule ExTaxjar.Transactions do
  def list(%{from_date: from_date, to_date: to_date}) do
    {:ok, %{body: body}} =
      ExTaxjar.get(
        "/transactions/orders",
        [],
        params: %{from_transaction_date: from_date, to_transaction_date: to_date}
      )

    body["orders"]
  end

  def list(%{on_date: on_date}) do
    {:ok, %{body: body}} =
      ExTaxjar.get("/transactions/orders", [], params: %{transaction_date: on_date})

    body["orders"]
  end
end
