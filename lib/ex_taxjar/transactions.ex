defmodule ExTaxjar.Transactions do
  def create_transaction(transaction) do
    {:ok, %{body: body}} =
      ExTaxjar.post("/transactions/orders", JSX.encode!(transaction), [
        {"Content-Type", "application/json"}
      ])

    body["order"]
  end

  def delete_transaction(id) do
    {:ok, %{body: body}} = ExTaxjar.delete("/transactions/orders/#{id}")
    body["order"]
  end

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

  def order(id) do
    {:ok, %{body: body}} = ExTaxjar.get("/transactions/orders/#{id}")
    body["order"]
  end

  def update_transaction(transaction = %{transaction_id: id}) do
    {:ok, %{body: body}} =
      ExTaxjar.put("/transactions/orders/#{id}", JSX.encode!(transaction), [
        {"Content-Type", "application/json"}
      ])

    body["order"]
  end
end
