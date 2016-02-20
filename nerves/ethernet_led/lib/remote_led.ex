defmodule RemoteLed do

  @moduledoc """
  Simple example to blink a list of LEDs forever.

  The list of LEDs is platform-dependent, and defined in the config
  directory (see config.exs).   See README.md for build instructions.
  """

  alias Nerves.IO.Led
  alias Nerves.IO.Ethernet

  require Logger


  def start(_type, args) do
    {:ok, _} = Ethernet.setup :eth0

    {:ok, self}
  end

  def led_on(led_key) do
    Logger.debug "Led ON -> #{inspect led_key}"
    Led.set [{led_key, true}]
  end

  def led_off(led_key) do
    Logger.debug "Led OFF -> #{inspect led_key}"
    Led.set [{led_key, false}]
  end

  def led_list do
    Application.get_env(:remote_led, :led_list)
  end

end
