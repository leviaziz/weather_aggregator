defmodule WeatherAggregator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WeatherAggregatorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WeatherAggregator.PubSub},
      # Start Finch
      {Finch, name: WeatherAggregator.Finch},
      # Start the Endpoint (http/https)
      WeatherAggregatorWeb.Endpoint
      # Start a worker by calling: WeatherAggregator.Worker.start_link(arg)
      # {WeatherAggregator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeatherAggregator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WeatherAggregatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
