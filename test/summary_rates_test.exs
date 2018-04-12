defmodule ExTaxjar.SummaryRatesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.SummaryRates

  test "list/0" do
    use_cassette "summary_rates#list" do
      resp = SummaryRates.list()
      assert Enum.count(resp) == 93
    end
  end
end
