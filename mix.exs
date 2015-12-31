defmodule Changelog.Mixfile do
  use Mix.Project

  @version File.read!("VERSION.md") |> String.strip

  def project do
    [
      app: :changelog,
      version: @version,
      elixir: "~> 1.1",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      docs: docs,
      escript: escript
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp docs do
    [
      extras: ["README.md", "LICENSE.md"]
    ]
  end

  defp escript do
    [
      main_module: Changelog.Cli
    ]
  end
end
