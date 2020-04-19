defmodule ReviewServer.Repo do
  use Ecto.Repo,
    otp_app: :review_server,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20
end
