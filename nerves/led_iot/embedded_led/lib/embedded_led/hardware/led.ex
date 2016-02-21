defmodule EmbeddedLed.Hardware.Led do
  require Logger

  def start_link do
    Logger.debug "#{__MODULE__}.start_link"

    loop
  end

  def switch_on(led_key) do
    Logger.debug "Switch led #{led_key} ON."
  end

  def switch_off(led_key) do
    Logger.debug "Switch led #{led_key} OFF."
  end

  defp loop do
    receive do
      {:on, led_key} ->
        switch_on(led_key)

      {:off, led_key} ->
        switch_on(led_key)

      other ->
        Logger.warn "unhandled message"
    end

    loop
  end
end
