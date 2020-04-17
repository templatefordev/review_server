defmodule ReviewServer.Repo do
  use Ecto.Repo,
    otp_app: :review_server,
    adapter: Ecto.Adapters.Postgres
end
