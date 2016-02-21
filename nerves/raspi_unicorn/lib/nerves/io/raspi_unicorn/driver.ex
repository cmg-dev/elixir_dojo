defmodule Nerves.IO.RaspiUnicorn.Driver do
  @moduledoc false

  use GenServer
  require Logger

  @doc """
  TODO
  """
  def start_link(settings, opts) do
    Logger.debug "#{__MODULE__} Starting"
    GenServer.start_link(__MODULE__, settings, opts)
  end

  @doc """
  TODO
  """
  def init(settings) do
    Logger.debug "#{__MODULE__} initializing: #{inspect settings}"
    pin   = settings[:pin]
    count = settings[:count]

    cmd = "#{:code.priv_dir(:raspi_unicorn)}/unicorn_dance #{pin} #{count}"
    Logger.debug "#{__MODULE__} calling: #{cmd}"
    port = Port.open({:spawn, cmd}, [:binary])
    {:ok, port}
  end

  @doc """
  TODO
  """
  def handle_call({:render, pixel_data}, _from, port) do
    Logger.debug "#{__MODULE__} rendering: #{inspect pixel_data}"
    Port.command(port, pixel_data)
    {:reply, :ok, port}
  end
end
