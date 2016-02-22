defmodule EmbeddedLed.Hardware.DummySender do
  require Logger

  def start_link do
    Logger.debug "#{__MODULE__} start"

    spawn fn ->
      loop(:on, :led)
    end

    {:ok, self}
  end

  def loop(state, pid) do
    Logger.debug "#{__MODULE__} start loop with #{inspect(pid)}"

    try do
      case state do
        :on ->
          GenServer.cast pid, {:off, :led0}
          :timer.sleep 5000
          loop(:off, pid)
        :off ->
          GenServer.cast pid, {:on, :led0}
          :timer.sleep 5000
          loop(:on, pid)
        _ ->
          Logger.warn "no pid given"
          :timer.sleep 5000
          loop(:on, pid)
      end
    rescue
      ArgumentError ->
        Logger.error "#{__MODULE__} ArgumentError with #{pid}"
    catch
      value ->
        Logger.error "#{__MODULE__} -> #{value}"
    end
  end
end
