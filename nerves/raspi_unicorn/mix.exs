defmodule Mix.Tasks.Compile.Ws281x do
  def run(_) do
    0 = Mix.Shell.IO.cmd("make priv/rpi_ws281x")
    Mix.Project.build_structure
    :ok
  end
end

defmodule Mix.Tasks.Compile.UnicornDance do
  def run(_) do
    0 = Mix.Shell.IO.cmd("make priv/unicorn_dance")
    Mix.Project.build_structure
    :ok
  end
end

defmodule RaspiUnicorn.Mixfile do
  use Mix.Project

  def project do
    [app: :raspi_unicorn,
     version: "0.0.1",
     elixir: "~> 1.1",
     compilers: [:UnicornDance, :elixir, :app],
     compilers: [:Ws281x, :elixir, :app],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:nerves,
                    :logger,
                    :nerves_io_led],
     mod: {RaspiUnicorn, []}]
  end

  defp deps, do: [
    {:nerves, github: "nerves-project/nerves"},
    {:nerves_io_led, github: "nerves-project/nerves_io_led"},
  ]

end
