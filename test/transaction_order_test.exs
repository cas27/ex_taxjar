defmodule ExTaxjar.TransactionOrderTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.{TransactionOrder, Transaction}

  describe "ExTaxjar.TransactionOrder.list/1" do
    test "with date range" do
      orders = TransactionOrder.list(%{from_date: "2017/01/01", to_date: "2017/01/31"})
      assert orders == ["with_sales_tax_order", "default"]
    end

    test "with specific day" do
      orders = TransactionOrder.list(%{on_date: "2017/01/31"})
      assert orders == ["with_sales_tax_order", "default"]
    end
  end

  describe "ExTaxjar.TransactionOrder.show/1" do
    test "get existing order" do
      use_cassette "transactions#order" do
        order = TransactionOrder.show("123")
        assert order["amount"] == "29.94"
      end
    end
  end

  describe "ExTaxjar.TransactionOrder.create/1" do
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

        resp = TransactionOrder.create(transaction)
        assert resp["transaction_id"] == "1999"
      end
    end
  end

  describe "ExTaxjar.TransactionOrder.update/1" do
    test "update transaction order" do
      use_cassette "transactions#update_transaction" do
        transaction = %Transaction.Update{
          transaction_id: "123",
          amount: 39.99
        }

        resp = TransactionOrder.update(transaction)
        assert resp["amount"] == "39.99"
      end
    end
  end

  describe "ExTaxjar.TransactionOrder.delete/1" do
    test "delete transaction order" do
      use_cassette "transactions#delete_transaction" do
        resp = TransactionOrder.delete("123")
        assert resp["amount"] == nil
        assert resp["to_country"] == nil
        assert resp["transaction_id"] == "123"
      end
    end
  end
end
