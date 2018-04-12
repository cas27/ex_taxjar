# ExTaxjar
[![Build Status](https://travis-ci.org/cas27/ex_taxjar.svg?branch=master)](https://travis-ci.org/cas27/ex_taxjar)

A client library for use with v2 of the [TaxJar API](https://developers.taxjar.com/api/reference/).

## Installation

Add ex_taxjar to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:ex_taxjar, "~> 0.5.0"}
  ]
end
```

Fetch your dependencies:

```
mix deps.get
```

Configure your environment:

```elixir
config :ex_taxjar,
  api_key: "TAXJAR_API_KEY",
  end_point: "https://api.taxjar.com/v2"
```

## Usage

### List all tax categories

```elixir
iex> ExTaxjar.Categories.list()
[
  %{
    "description" => "Digital products transferred electronically, meaning obtained by the purchaser by means other than tangible storage media.",
    "name" => "Digital Goods",
    "product_tax_code" => "31000"
  },
  %{
    "description" => " All human wearing apparel suitable for general use", 
    "name" => "Clothing",
    "product_tax_code" => "20010"
  },
  %{
    "description" => "Drugs for human use without a prescription",
    "name" => "Non-Prescription",
    "product_tax_code" => "51010"
  },
  %{
    "description" => "Drugs for human use with a prescription",
    "name" => "Prescription",
    "product_tax_code" => "51020"
  },
  %{
    "description" => "Food for humans consumption, unprepared",
    "name" => "Food & Groceries",
    "product_tax_code" => "40030"
  }, ....
]
```

### List tax rates for location (by zip/postal code)

```elixir
iex> ExTaxjar.Rates.rate("90210")
%{
  "city" => "WESTLAKE",
  "city_rate" => "0.0",
  "combined_district_rate" => "0.0225",
  "combined_rate" => "0.095",
  "county" => "LOS ANGELES",
  "county_rate" => "0.01",
  "freight_taxable" => false,
  "state" => "CA",
  "state_rate" => "0.0625",
  "zip" => "90210"
}
iex> # International Example
iex> ExTaxjar.Rates.rate("10115", %{country: "DE"})
%{
  "country" => "DE", 
  "distance_sale_threshold" => nil,
  "freight_taxable" => true,
  "name" => "Germany",
  "parking_rate" => nil,
  "reduced_rate" => nil,
  "standard_rate" => "0.19",
  "super_reduced_rate" => nil
}
```

### Calculate Sales Tax for an order

```elixir
iex> order = %ExTaxjar.Order{
  amount: 100,
  from_city: "Beverly Hills",
  from_country: "US",
  from_state: "CA",
  from_street: "123 Water St",
  from_zip: "90210",
  line_items: [],
  nexus_adresses: [],
  shipping: 15,
  to_city: "Los Angeles",
  to_country: "US",
  to_state: "CA",
  to_street: "1335 E 103rd St",
  to_zip: "90002"
}
iex> ExTaxjar.Taxes.tax(order)
%{
  "amount_to_collect" => 9.5,
  "freight_taxable" => false,
  "has_nexus" => true,
  "order_total_amount" => 115.0,
  "rate" => 0.095,
  "shipping" => 15.0,
  "tax_source" => "destination",
  "taxable_amount" => 100.0
}
```

### List order transactions

```elixir
iex(7)> ExTaxjar.TransactionOrder.list(
%{from_date: "2014/01/01", to_date: "2014/01/31"}
)
["123", "124"]
```

### Show order transaction

```elixir
iex> ExTaxjar.TransactionOrder.show("123")
%{
  "amount" => "29.94",
  "from_city" => nil,
  "from_country" => "US",
  "from_state" => "CA",
  "from_street" => nil,
  "from_zip" => "90210",
  "line_items" => [
    %{
      "description" => nil,
      "discount" => "1.0",
      "id" => 0,
      "product_identifier" => nil,
      "product_tax_code" => "31000",
      "quantity" => 1,
      "sales_tax" => "0.0",
      "unit_price" => "19.99"
    },
    %{
      "description" => nil,
      "discount" => "2.0",
      "id" => 1,
      "product_identifier" => nil,
      "product_tax_code" => "30070",
      "quantity" => 1,
      "sales_tax" => "0.0",
      "unit_price" => "9.95"
    }
  ],
  "sales_tax" => "0.0",
  "shipping" => "0.0",
  "to_city" => nil,
  "to_country" => "US",
  "to_state" => "CA",
  "to_street" => nil,
  "to_zip" => "90210",
  "transaction_date" => "2016-08-20T00:00:00.000Z",
  "transaction_id" => "123",
  "transaction_reference_id" => nil,
  "user_id" => 2
  }
```

### Create order transaction

```elixir
iex>transaction =
%ExTaxjar.Transaction{
  amount: 19.99,
  from_city: nil,
  from_country: nil,
  from_state: nil,
  from_street: nil,
  from_zip: nil,
  line_items: [],
  sales_tax: 1.19,
  shipping: 4.99,
  to_city: nil,
  to_country: "US",
  to_state: "CA",
  to_street: nil,
  to_zip: "90210",
  transaction_date: "1999/01/01",
  transaction_id: "1999"
}
iex(10)> ExTaxjar.TransactionOrder.create(transaction)
%{
  "amount" => "19.99",
  "from_city" => nil,
  "from_country" => "US",
  "from_state" => nil,
  "from_street" => nil,
  "from_zip" => "",
  "line_items" => [],
  "sales_tax" => "1.19",
  "shipping" => "4.99",
  "to_city" => nil,
  "to_country" => "US",
  "to_state" => "CA",
  "to_street" => nil,
  "to_zip" => "90210",
  "transaction_date" => "1999-01-01T00:00:00.000Z",
  "transaction_id" => "1999",
  "transaction_reference_id" => nil,
  "user_id" => 17108
}
```

### Update an order transaction

```elixir
iex> transaction = %ExTaxjar.Transaction.Update{
...> transaction_id: "123",
...> amount: 39.99
...> }
%ExTaxjar.Transaction.Update{
  amount: 39.99,
  from_city: nil,
  from_country: nil,
  from_state: nil,
  from_street: nil,
  from_zip: nil,
  line_items: [],
  sales_tax: nil,
  shipping: nil,
  to_city: nil,
  to_country: nil,
  to_state: nil,
  to_street: nil,
  to_zip: nil,
  transaction_date: nil,
  transaction_id: "123"
}
iex> ExTaxjar.TransactionOrder.update(transaction)
%{
  "amount" => "39.99",
  "from_city" => nil,
  "from_country" => "US",
  "from_state" => nil,
  "from_street" => nil,
  "from_zip" => "",
  "line_items" => [],
  "sales_tax" => "0.0",
  "shipping" => "0.0",
  "to_city" => nil,
  "to_country" => "US",
  "to_state" => nil,
  "to_street" => nil,
  "to_zip" => "",
  "transaction_date" => "2018-04-12T17:04:13.519Z",
  "transaction_id" => "123",
  "transaction_reference_id" => nil,
  "user_id" => 17108
}
```

### Delete order transaction

```elixir
iex(13)> ExTaxjar.TransactionOrder.delete("123")
%{
  "amount" => nil,
  "from_city" => nil,
  "from_country" => nil,
  "from_state" => nil,
  "from_street" => nil,
  "from_zip" => nil, 
  "line_items" => [],
  "sales_tax" => nil,
  "shipping" => nil,
  "to_city" => nil,
  "to_country" => nil,
  "to_state" => nil,
  "to_street" => nil,
  "to_zip" => nil,
  "transaction_date" => nil,
  "transaction_id" => "123",
  "transaction_reference_id" => nil,
  "user_id" => 17108
}
```

### List refund transactions

```elixir
iex(14)> ExTaxjar.TransactionRefund.list(
  ...> %{on_date: "2017/01/01"})
["321", "322"]
```

### Show refund transaction

```elixir
iex> ExTaxjar.TransactionRefund.show("321")
%{
  "amount" => "-29.94",
  "from_city" => nil,
  "from_country" => "US",
  "from_state" => "CA",
  "from_street" => nil,
  "from_zip" => "90210",
  "line_items" => [
    %{
      "description" => nil,
      "discount" => "1.0",
      "id" => 0,
      "product_identifier" => nil,
      "product_tax_code" => "31000",
      "quantity" => 1,
      "sales_tax" => "0.0",
      "unit_price" => "-19.99"
    },
    %{
      "description" => nil,
      "discount" => "2.0",
      "id" => 1,
      "product_identifier" => nil,
      "product_tax_code" => "30070",
      "quantity" => 1,
      "sales_tax" => "0.0",
      "unit_price" => "-9.95"
    }
  ],
  "sales_tax" => "0.0",
  "shipping" => "-1.0",
  "to_city" => nil,
  "to_country" => "US",
  "to_state" => "CA",
  "to_street" => nil,
  "to_zip" => "90210",
  "transaction_date" => "2016-09-20T00:00:00.000Z",
  "transaction_id" => "321",
  "transaction_reference_id" => "123A",
  "user_id" => 2
  }
```

### Create refund transaction

```elixir
iex> refund = %ExTaxjar.Refund{
...>           transaction_id: "1999",
...>           transaction_reference_id: "1999",
...>           transaction_date: "1999/01/01",
...>           to_country: "US",
...>           to_zip: "90210",
...>           to_state: "CA",
...>           amount: 19.99,
...>           shipping: 4.99,
...>           sales_tax: 1.19
...> }
%ExTaxjar.Refund{
  amount: 19.99,
  from_city: nil,
  from_country: nil,
  from_state: nil,
  from_street: nil,
  from_zip: nil,
  line_items: [],
  sales_tax: 1.19, 
  shipping: 4.99,
  to_city: nil,
  to_country: "US",
  to_state: "CA",
  to_street: nil,
  to_zip: "90210",
  transaction_date: "1999/01/01",
  transaction_id: "1999",
  transaction_reference_id: "1999"
  }
```

### Update refund transaction

```elixir
iex> refund = %ExTaxjar.Refund.Update{
...>           transaction_id: "321",
...>           transaction_reference_id: "1999",
...>           amount: 39.99
...> }
iex> ExTaxjar.TransactionRefund.update(refund)
%{
  "amount" => "-39.99",
  "from_city" => nil,
  "from_country" => "US",
  "from_state" => nil,
  "from_street" => nil,
  "from_zip" => "",
  "line_items" => [],
  "sales_tax" => "0.0",
  "shipping" => "0.0",
  "to_city" => nil,
  "to_country" => "US",
  "to_state" => nil,
  "to_street" => nil,
  "to_zip" => "",
  "transaction_date" => "2018-04-12T17:22:20.843Z",
  "transaction_id" => "321",
  "transaction_reference_id" => "1999",
  "user_id" => 17108
}
```

### Delete refund transaction

```elixir
iex(6)> ExTaxjar.TransactionRefund.delete("321")
%{
  "amount" => nil,
  "from_city" => nil,
  "from_country" => nil,
  "from_state" => nil,
  "from_street" => nil,
  "from_zip" => nil, 
  "line_items" => [],
  "sales_tax" => nil,
  "shipping" => nil,
  "to_city" => nil,
  "to_country" => nil,
  "to_state" => nil,
  "to_street" => nil,
  "to_zip" => nil,
  "transaction_date" => nil,
  "transaction_id" => "321",
  "transaction_reference_id" => nil,
  "user_id" => 17108
  }
```

### List nexus regions

```elixir
iex> ExTaxjar.Nexus.list()
[
  %{
    "country" => "United States",
    "country_code" => "US",
    "region" => "California",
    "region_code" => "CA"
  }
]
```

### Validate a VAT number

```elixir
iex> ExTaxjar.Validations.validate("FR40303265045")
%{
  "exists" => true,
  "valid" => true,
  "vies_available" => true,
  "vies_response" => %{
    "address" => "11 RUE AMPERE\n26600 PONT DE L ISERE",
    "country_code" => "FR",
    "name" => "SA SODIMAS",
    "request_date" => "2018-04-12",
    "valid" => true,
    "vat_number" => "40303265045"
  }
  }
```

### Summarize tax rates for all regions

```elixir
iex> ExTaxjar.SummaryRates.list()
[
  %{
    "average_rate" => %{"label" => "VAT", "rate" => 0.2},
    "country" => "Austria",
    "country_code" => "AT",
    "minimum_rate" => %{"label" => "VAT", "rate" => 0.2},
    "region" => nil,
    "region_code" => nil
  },
  %{
    "average_rate" => %{"label" => "VAT", "rate" => 0.21},
    "country" => "Belgium",
    "country_code" => "BE",
    "minimum_rate" => %{"label" => "VAT", "rate" => 0.21},
    "region" => nil,
    "region_code" => nil
  },
  %{
    "average_rate" => %{"label" => "VAT", "rate" => 0.2},
    "country" => "Bulgaria",
    "country_code" => "BG",
    "minimum_rate" => %{"label" => "VAT", "rate" => 0.2},
    "region" => nil,
    "region_code" => nil
  },
  %{
    "average_rate" => %{"label" => "GST", "rate" => 0.05},
    "country" => "Canada",
    "country_code" => "CA",
    "minimum_rate" => %{"label" => "GST", "rate" => 0.05},
    "region" => "Alberta",
    "region_code" => "AB"
  },
  %{
    "average_rate" => %{"label" => "GST/PST", "rate" => 0.12},
    "country" => "Canada",
    "country_code" => "CA",
    "minimum_rate" => %{"label" => "GST", "rate" => 0.05},
    "region" => "British Columbia",
    "region_code" => "BC"
  },
  ...]
```
