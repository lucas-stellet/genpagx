defmodule Genpagx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Genpagx.Repo,
      # Start the Telemetry supervisor
      GenpagxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Genpagx.PubSub},
      # Start the Endpoint (http/https)
      GenpagxWeb.Endpoint
      # Start a worker by calling: Genpagx.Worker.start_link(arg)
      # {Genpagx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Genpagx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GenpagxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
