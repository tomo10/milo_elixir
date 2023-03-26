defmodule Milo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MiloWeb.Telemetry,
      # Start the Ecto repository
      Milo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Milo.PubSub},
      # Start Finch
      {Finch, name: Milo.Finch},
      # Start the Endpoint (http/https)
      MiloWeb.Endpoint
      # Start a worker by calling: Milo.Worker.start_link(arg)
      # {Milo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Milo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MiloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
