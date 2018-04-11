defmodule ExTaxjar.TransactionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Transactions

  # I'm assuming this has not been implemented in the sandbox yet or has a bug
  @tag :skip
  test "list/1 with range" do
    orders = Transactions.list(%{from_date: "2017/01/01", to_date: "2017/01/31"})
    assert Enum.count(orders) == 2
  end

  # I'm assuming this has not been implemented in the sandbox yet or has a bug
  @tag :skip
  test "list/1 with specific day" do
    orders = Transactions.list(%{on_date: "2017/01/31"})
    assert Enum.count(orders) == 2
  end
end
