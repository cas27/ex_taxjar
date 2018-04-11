defmodule ExTaxjar.TransactionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.{Transactions, Transaction}

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

  describe "ExTaxjar.Transactions.create_transaction/1" do
    test "creates a new order transaction" do
      use_cassette "transactions#create_transaction" do
        transaction = %Transaction{
          transaction_id: "1999",
          transaction_date: "1999/01/01",
          to_country: "US",
          to_zip: "90210",
          to_state: "CA",
          amount: 19.99,
          shipping: 4.99,
          sales_tax: 1.19
        }

        resp = Transactions.create_transaction(transaction)
        assert resp["transaction_id"] == "1999"
      end
    end
  end

  describe "ExTaxjar.Transactions.update_transaction/1" do
    test "update transaction order" do
      use_cassette "transactions#update_transaction" do
        transaction = %Transaction{
          transaction_id: "123",
          transaction_date: "1999/01/01",
          to_country: "US",
          to_zip: "90210",
          to_state: "CA",
          amount: 39.99,
          shipping: 4.99,
          sales_tax: 1.19
        }

        resp = Transactions.update_transaction(transaction)
        assert resp["amount"] == "39.99"
      end
    end
  end

  describe "ExTaxjar.Transactions.delete_transaction/1" do
    test "delete transaction order" do
      use_cassette "transactions#delete_transaction" do
        resp = Transactions.delete_transaction("123")
        assert resp["amount"] == nil
        assert resp["to_country"] == nil
        assert resp["transaction_id"] == "123"
      end
    end
  end
end
