defmodule EmbeddedLed.Hardware.Led do
  use GenServer

  alias Nerves.IO.Led

  require Logger

  def start_link do
    Logger.debug "#{__MODULE__}.start_link"

    GenServer.start_link(__MODULE__, [], name: :led)
  end

  def handle_cast({:on, led_key}, state) do
    Logger.debug "Switch led #{led_key} ON."

    Led.set [{led_key, true}]

    {:noreply, [led_key | state]}
  end

  def handle_cast({:on, led_key, led_state}, state) do
    Logger.debug "Switch led #{led_key} to #{led_state}."

    Led.set [{led_key, led_state}]

    {:noreply, [led_key | state]}
  end

  def handle_cast({:off, led_key}, state) do
    Logger.debug "Switch led #{led_key} OFF."

    Led.set [{led_key, false}]

    {:noreply, [led_key | state]}
  end

  def handle_call(:led_keys, _from, state) do
    led_keys = Application.get_env :embedded_led, :led_list

    Logger.debug "reply led_keys: #{inspect(led_keys)}"

    {:reply, led_keys, state}
  end

end
