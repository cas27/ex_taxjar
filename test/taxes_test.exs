defmodule ExTaxjar.TaxesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.{Taxes, Order, LineItem}

  test "tax/1" do
    use_cassette "taxes#tax1" do
      order = %Order{
        from_country: "US",
        from_zip: "90210",
        from_state: "CA",
        from_city: "Beverly Hills",
        from_street: "123 Water St",
        to_country: "US",
        to_zip: "90002",
        to_state: "CA",
        to_city: "Los Angeles",
        to_street: "1335 E 103rd St",
        amount: 100,
        shipping: 15
      }

      tax = Taxes.tax(order)
      assert tax["amount_to_collect"] == 9.5
    end
  end

  test "tax/1 with line item instead of amount" do
    use_cassette "taxes#line_items" do
      order = %Order{
        from_country: "US",
        from_zip: "90210",
        from_state: "CA",
        from_city: "Beverly Hills",
        from_street: "123 Water St",
        to_country: "US",
        to_zip: "90002",
        to_state: "CA",
        to_city: "Los Angeles",
        to_street: "1335 E 103rd St",
        shipping: 15,
        line_items: [%LineItem{id: 1, quantity: 11, unit_price: 10, product_tax_code: "20010"}]
      }

      tax = Taxes.tax(order)
      assert tax["amount_to_collect"] == 10.45
    end
  end
end
