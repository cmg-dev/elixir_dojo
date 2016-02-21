defmodule RaspiUnicorn do

  @moduledoc """
  """
  require Logger

  def start(_type, _args) do
    start_child
    led_list = Application.get_env(:raspi_unicorn, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    spawn fn -> blink_list_forever(led_list) end
    {:ok, self}
  end

  @doc """
  """
  defp start_child do
    import Supervisor.Spec

    settings = [pin: 18, count: 3]

    children = [worker(Nerves.IO.RaspiUnicorn.Driver, [settings, [name: :unicorn_dance]])]
    Supervisor.start_link(children, strategy: :one_for_one)

    Logger.debug "#{__MODULE__} Setup done"
  end

  @doc """
  """
  defp render!(pixel_data) do
    GenServer.call(:unicorn_dance, {:render, pixel_data})
  end

  @doc """
  call blink_led on each led in the list sequence, repeating forever
  """
  defp blink_list_forever(led_list) do
    Enum.each(led_list, &blink(&1))
    blink_list_forever(led_list)
  end

  @doc """
  given an led key, turn it on for some ms then back off
  """
  defp blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    Nerves.IO.Led.set [{led_key, true}]
    :timer.sleep 5000
    Nerves.IO.Led.set [{led_key, false}]
  end

end
