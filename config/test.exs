use Mix.Config

config :ex_taxjar,
  api_key: System.get_env("TAXJAR_SB_API_KEY"),
  end_point: "https://api.sandbox.taxjar.com/v2"

config :exvcr,
  filter_sensitive_data: [
    [pattern: "Bearer [0-9a-z]+", placeholder: "<<access_key>>"]
  ],
  response_headers_blacklist: ["Set-Cookie", "X-Request-Id", "Etag"]
