# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :account_api,
  ecto_repos: [AccountApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :account_api, AccountApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: AccountApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AccountApi.PubSub,
  live_view: [signing_salt: "dbLcUB2s"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :account_api, AccountApiWeb.Auth.Guardian,
  issuer: "account_api",
  secret_key: "yfIT5zjWQBiAm8ZaT2SI7TBQXh0hsmOeeUjT1M/a40vg+lWKTLlDP608n6jo9nWK"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
