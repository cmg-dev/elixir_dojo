defmodule EmbeddedLed.Mixfile do
  use Mix.Project

  def project do
    [app: :embedded_led,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :nerves, :nerves_io_led, :nerves_io_ethernet],
      mod: {EmbeddedLed.Application, []}
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
      {:nerves, github: "nerves-project/nerves"},
      {:nerves_io_led, github: "nerves-project/nerves_io_led"},
      {:nerves_io_ethernet, github: "nerves-project/nerves_io_ethernet"}
    ]
  end
end
