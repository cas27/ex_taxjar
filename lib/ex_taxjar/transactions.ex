defmodule ExTaxjar.Transactions do
  defmacro __using__(resource: resource) do
    resources = resource <> "s"

    quote do
      def create(transaction) do
        {:ok, %{body: body}} =
          ExTaxjar.post("/transactions/#{unquote(resources)}", JSX.encode!(transaction), [
            {"Content-Type", "application/json"}
          ])

        body[unquote(resource)]
      end

      def delete(id) do
        {:ok, %{body: body}} = ExTaxjar.delete("/transactions/#{unquote(resources)}/#{id}")
        body[unquote(resource)]
      end

      def list(%{from_date: from_date, to_date: to_date}) do
        {:ok, %{body: body}} =
          ExTaxjar.get(
            "/transactions/#{unquote(resources)}",
            [],
            params: %{from_transaction_date: from_date, to_transaction_date: to_date}
          )

        body[unquote(resources)]
      end

      def list(%{on_date: on_date}) do
        {:ok, %{body: body}} =
          ExTaxjar.get(
            "/transactions/#{unquote(resources)}",
            [],
            params: %{transaction_date: on_date}
          )

        body[unquote(resources)]
      end

      def show(id) do
        {:ok, %{body: body}} = ExTaxjar.get("/transactions/#{unquote(resources)}/#{id}")
        body[unquote(resource)]
      end

      def update(transaction = %{transaction_id: id}) do
        {:ok, %{body: body}} =
          ExTaxjar.put("/transactions/#{unquote(resources)}/#{id}", JSX.encode!(transaction), [
            {"Content-Type", "application/json"}
          ])

        body[unquote(resource)]
      end
    end
  end
end
