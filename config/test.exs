use Mix.Config

# Configure your database
config :review_server, ReviewServer.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "review_server_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :review_server, ReviewServerWeb.Endpoint,
  http: [port: 6002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
