defmodule EmbeddedLed.Hardware.Ethernet do
  use GenServer

  alias Nerves.IO.Ethernet

  require Logger

  def start_link do
    Logger.debug "#{__MODULE__}.start_link #{Kernel.node}"

    {:ok, _} = Ethernet.setup :eth0

    GenServer.start_link(__MODULE__, nil, name: :ethernet)
  end
end
