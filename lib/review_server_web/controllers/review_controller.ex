defmodule ReviewServerWeb.ReviewController do
  use ReviewServerWeb, :controller

  action_fallback ReviewServerWeb.FallbackController

  def index(conn, params) do
    form = Forms.ListReviews.changeset(params)

    case form.valid? do
      true ->
        page = Queries.ListReviews.call(form.changes)
        render(conn, "index.json", reviews: page.entries, meta: build_meta(page))

      false ->
        {:error, form}
    end
  end
end
