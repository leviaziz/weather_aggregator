import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :weather_aggregator, WeatherAggregatorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "O6AuY+DsgxKIcCkm55Qm/DPlRF26utVyIvcQO6d8ITUWY3D8UXvSVaLT4LyesUcA",
  server: false

# In test we don't send emails.
config :weather_aggregator, WeatherAggregator.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Add weather APIs modules
config :weather_aggregator, :tomorrow_io, WeatherAggregator.WeatherApi.TomorrowIoTest
config :weather_aggregator, :visual_crossing, WeatherAggregator.WeatherApi.VisualCrossingTest
