defmodule ReviewServerWeb.ResourceController do
  use ReviewServerWeb, :controller

  action_fallback ReviewServerWeb.FallbackController

  def show(conn, %{"id" => id}) do
    resource = Repo.get!(ResourceStats, id)
    render(conn, "show.json", resource: resource)
  end
end
