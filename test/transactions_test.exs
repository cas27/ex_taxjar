defmodule ExTaxjar.TransactionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Transactions

  describe "ExTaxjar.Transactions.list/1" do
    # I'm assuming this has not been implemented in the sandbox yet or has a bug
    @tag :skip
    test "with date range" do
      orders = Transactions.list(%{from_date: "2017/01/01", to_date: "2017/01/31"})
      assert Enum.count(orders) == 2
    end

    # I'm assuming this has not been implemented in the sandbox yet or has a bug
    @tag :skip
    test "with specific day" do
      orders = Transactions.list(%{on_date: "2017/01/31"})
      assert Enum.count(orders) == 2
    end
  end

  describe "ExTaxjar.Transactions.order/1" do
    test "get existing order" do
      use_cassette "transactions#order" do
        order = Transactions.order("123")
        assert order["amount"] == "29.94"
      end
    end
  end
end
