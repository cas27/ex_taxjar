defmodule ExTaxjar.ValidationsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Validations

  test "validate/1" do
    use_cassette "validatoins#validate" do
      resp = Validations.validate("FR40303265045")
      assert resp["valid"] == true
      assert resp["exists"] == true
      assert resp["vies_response"]["country_code"] == "FR"
    end
  end
end
