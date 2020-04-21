defmodule Tasks.Release do
  @moduledoc """
  Provides a functions `migrate/0`, `rollback/2` to change database schema.

  ## Examples
      _build/prod/rel/review_server/bin/review_server eval "Tasks.Release.migrate"
  """

  @app :review_server

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
