defmodule ExTaxjar do
  use HTTPoison.Base

  @moduledoc """
  Documentation for ExTaxjar.
  """

  def process_url(url) do
    "https://api.taxjar.com/v2" <> url
  end

  def process_response_body(body) do
    body
    |> JSX.decode!
  end

  def process_request_headers(headers) do
    headers ++ ["Authorization": "Bearer #{Application.get_env(:ex_taxjar, :api_key)}"]
  end
end
