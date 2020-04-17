# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :review_server,
  ecto_repos: [ReviewServer.Repo]

config :review_server, ReviewServer.Repo, migration_timestamps: [type: :timestamptz]

# Configures the endpoint
config :review_server, ReviewServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GF75CLBzZcjL4c1qd76txnq10nLzqVbgcz7b7oXSldGYxdRAscOiZz5BJm7Nj0QF",
  render_errors: [view: ReviewServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ReviewServer.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "lrvykBOJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
