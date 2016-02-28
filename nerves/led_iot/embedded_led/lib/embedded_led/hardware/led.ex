defmodule EmbeddedLed.Hardware.Led do
  use GenServer

  alias Nerves.IO.Led

  require Logger

  ## API

  def led_on(pid, led) do
    GenServer.cast({:led, pid}, {:on, led})
  end

  def led_off(pid, led) do
    GenServer.cast({:led, pid}, {:off, led})
  end

  def led_list(pid) do
    GenServer.call({:led, pid}, :led_keys)
  end

  ## GenServer implementation

  def start_link do
    Logger.debug "#{__MODULE__}.start_link"

    Enum.map get_configured_led_list, fn (led_key) ->
      module_key = "__MODULE__#{led_key}"
      name = "led_#{led_key}"

      Logger.debug "#{__MODULE__} -> GenServer.start(#{module_key}, [#{led_key}], name: #{name})"

      #GenServer.start(module_key, [led_key], name: name)
    end
    #{:ok, self}

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
    led_keys = get_configured_led_list

    Logger.debug "reply led_keys: #{inspect(led_keys)}"

    {:reply, led_keys, state}
  end

  defp get_configured_led_list do
    Application.get_env :embedded_led, :led_list
  end

end
