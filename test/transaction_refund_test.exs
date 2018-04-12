defmodule ExTaxjar.TransactionRefundTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.{TransactionRefund, Refund}

  describe "ExTaxjar.TransactionRefund.list/1" do
    # I'm assuming this has not been implemented in the sandbox yet or has a bug
    @tag :skip
    test "with date range" do
      refunds = TransactionRefund.list(%{from_date: "2017/01/01", to_date: "2017/01/31"})
      IO.puts(inspect(refunds))
      assert Enum.count(refunds) == 2
    end

    # I'm assuming this has not been implemented in the sandbox yet or has a bug
    @tag :skip
    test "with specific day" do
      refunds = TransactionRefund.list(%{on_date: "2017/01/31"})
      assert Enum.count(refunds) == 2
    end
  end

  describe "ExTaxjar.TransactionRefund.show/1" do
    test "get existing refund" do
      use_cassette "transactions#refund" do
        refund = TransactionRefund.show("321")
        assert refund["amount"] == "-29.94"
      end
    end
  end

  describe "ExTaxjar.TransactionRefund.create/1" do
    test "creates a new refund transaction" do
      use_cassette "transactions#create_refund" do
        refund = %Refund{
          transaction_id: "1999",
          transaction_reference_id: "1999",
          transaction_date: "1999/01/01",
          to_country: "US",
          to_zip: "90210",
          to_state: "CA",
          amount: 19.99,
          shipping: 4.99,
          sales_tax: 1.19
        }

        resp = TransactionRefund.create(refund)
        assert resp["transaction_id"] == "1999"
      end
    end
  end

  describe "ExTaxjar.TransactionRefund.update/1" do
    test "update transaction refund" do
      use_cassette "transactions#update_refund" do
        refund = %Refund.Update{
          transaction_id: "321",
          transaction_reference_id: "1999",
          amount: 39.99
        }

        resp = TransactionRefund.update(refund)
        assert resp["amount"] == "-39.99"
      end
    end
  end

  describe "ExTaxjar.TransactionRefund.delete/1" do
    test "delete transaction refund" do
      use_cassette "transactions#delete_refund" do
        resp = TransactionRefund.delete("321")
        assert resp["amount"] == nil
        assert resp["to_country"] == nil
        assert resp["transaction_id"] == "321"
      end
    end
  end
end
