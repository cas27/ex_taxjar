use Mix.Config

config :ex_taxjar,
  api_key: System.get_env("TAXJAR_API_KEY"),
  end_point: "https://api.taxjar.com/v2"

#
# and access this configuration in your application as:
#
#     Application.get_env(:ex_taxjar, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info

import_config "#{Mix.env()}.exs"
