defmodule ExTaxjar.RatesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Rates

  test "rate/2 with zip code 90210" do
    use_cassette "rates#rate1" do
      rate = Rates.rate("90210")
      assert rate["combined_rate"] == "0.095"
      assert rate["state"] == "CA"
    end
  end

  test "rate/2 with optional params" do
    use_cassette "rates#rate2" do
      rate = Rates.rate("82003", %{state: "WY", city: "Cheyenne"})
      assert rate["combined_rate"] == "0.06"
      assert rate["state"] == "WY"
    end
  end

  test "rate/2 for Germany" do
    use_cassette "rates#germany" do
      rate = Rates.rate("10115", %{country: "DE"})
      assert rate["name"] == "Germany"
      assert rate["standard_rate"] == "0.19"
    end
  end
end
