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

    settings = [led_x: 1, led_y: 1]

    children = [
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 0, led_y: 0], [name: :x0y0]], id: :x0y0),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 1, led_y: 1], [name: :x1y1]], id: :x1y1),
      worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 2, led_y: 2], [name: :x2y2]], id: :x2y2),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 3, led_y: 3], [name: :x3y3]], id: :x3y3),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 4, led_y: 4], [name: :x4y4]], id: :x4y4),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 5, led_y: 5], [name: :x5y5]], id: :x5y5),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 6, led_y: 6], [name: :x6y6]], id: :x6y6),
      #worker(Nerves.IO.RaspiUnicorn.Driver, [[led_x: 7, led_y: 7], [name: :x7y7]], id: :x7y7)
    ]
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
