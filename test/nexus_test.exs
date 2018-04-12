defmodule ExTaxjar.NexusTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExTaxjar.Nexus

  test "list/0" do
    use_cassette "nexus#list" do
      resp = Nexus.list()
      assert Enum.count(resp) == 1
    end
  end
end
