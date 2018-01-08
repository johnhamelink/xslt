defmodule Xslt.Mixfile do
  use Mix.Project

  def project do
    [app: :xslt,
     version: "0.1.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     name: "Xslt",
     description: "A lightweight wrapper around xsltproc",
     source_url: "https://github.com/johnhamelink/xslt",
     homepage_url: "https://hexdocs.pm/xslt",
     docs: [
       main: "Xslt",
       extras: ["README.md"]
     ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:porcelain, "~> 2.0"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:eliver, "~> 1.0.0", only: :dev}
    ]
  end

  defp package do
    [
      name: :xslt,
      files: ["lib", "config", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["John Hamelink"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/johnhamelink/xslt",
        "Docs"   => "https://hexdocs.pm/xslt"
      }
    ]
  end

end
