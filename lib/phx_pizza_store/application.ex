defmodule PhxPizzaStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxPizzaStoreWeb.Telemetry,
      PhxPizzaStore.Repo,
      {DNSCluster, query: Application.get_env(:phx_pizza_store, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxPizzaStore.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxPizzaStore.Finch},
      # Start a worker by calling: PhxPizzaStore.Worker.start_link(arg)
      # {PhxPizzaStore.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxPizzaStoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxPizzaStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxPizzaStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
