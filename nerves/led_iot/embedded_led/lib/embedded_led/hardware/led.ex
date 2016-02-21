defmodule EmbeddedLed.Hardware.Led do
  use GenServer

  require Logger

  def start_link do
    Logger.debug "#{__MODULE__}.start_link"

    GenServer.start_link(__MODULE__, [], name: :led)
  end

  def handle_cast({:on, led_key}, state) do
    Logger.debug "Switch led #{led_key} ON."

    {:noreply, [led_key | state]}
  end

  def handle_cast({:off, led_key}, state) do
    Logger.debug "Switch led #{led_key} OFF."

    {:noreply, [led_key | state]}
  end
end
