defmodule ExTaxjar.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_taxjar,
      version: "0.5.0",
      elixir: "~> 1.6",
      name: "ExTaxjar",
      description: description()
      package: package()
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.1"},
      {:exjsx, "~> 4.0"},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "A client library for use with v2 of the TaxJar API"
  end

  defp package do
    [
      maintainers: ["Cory Schmitt"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/cas27/ex_taxjar"}
    ]
    
  end
end
