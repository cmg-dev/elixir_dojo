defmodule EmbeddedLed.Hardware.Ethernet do
  use GenServer

  require Logger

  def start_link do
    Logger.debug "#{__MODULE__}.start_link #{Kernel.node}"

    GenServer.start_link(__MODULE__, nil, name: :ethernet)
  end
end
