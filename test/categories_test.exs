defmodule ExTaxjar.CategoriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Categories

  test "list/0" do
    use_cassette "categories#list" do
      assert Enum.count(Categories.list()) == 17
    end
  end
end
