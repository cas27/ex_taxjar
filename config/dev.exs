use Mix.Config

config :ex_taxjar,
  api_key: System.get_env("TAXJAR_SB_API_KEY"),
  end_point: "https://api.sandbox.taxjar.com/v2"
