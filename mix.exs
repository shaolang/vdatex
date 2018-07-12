defmodule VDatex.MixProject do
  use Mix.Project

  def project do
    [
      app: :vdatex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      package: [
        name: "vdatex",
        licenses: ["Apache 2.0"],
        links: %{"Github" => "https://github.com/shaolang/vdatex"}
      ],
      descriptions: "FX value date calculation",
      deps: deps(),
      name: "VDatex",
      source_url: "https://github.com/shaolang/vdatex"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {VDatex.Application, []}
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:stream_data, "~> 0.4.2", only: :test}
    ]
  end
end
