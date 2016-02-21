defmodule EmbeddedLed.Application do
  use Application

  require Logger

  def start(_, _) do
    Logger.debug("Application.start")
    import Supervisor.Spec, warn: false

    children = [
      worker(EmbeddedLed.Hardware.Ethernet, []),
      worker(EmbeddedLed.Hardware.Led, []) #,
      #worker(EmbeddedLed.Hardware.DummySender, [])
    ]
    opts = [strategy: :one_for_one, name: EmbeddedLed.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
