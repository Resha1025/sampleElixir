defmodule SampleElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SampleElixirWeb.Telemetry,
      SampleElixir.Repo,
      {DNSCluster, query: Application.get_env(:sampleElixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SampleElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SampleElixir.Finch},
      # Start a worker by calling: SampleElixir.Worker.start_link(arg)
      # {SampleElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      SampleElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SampleElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SampleElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
