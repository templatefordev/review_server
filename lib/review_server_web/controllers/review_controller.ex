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

  def show(conn, %{"id" => id}) do
    review = ReviewServer.Repo.get!(Review, id)
    render(conn, "show.json", review: review)
  end

  def create(conn, %{"review" => review_params}) do
    form = Forms.CreateReview.changeset(review_params)

    case form.valid? do
      true ->
        with {:ok, %Review{} = review} <- Commands.CreateReview.call(form.changes) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.review_path(conn, :show, review))
          |> render("show.json", review: review)
        end

      false ->
        {:error, form}
    end
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = ReviewServer.Repo.get!(Review, id)
    form = Forms.UpdateReview.changeset(review_params)

    with {:ok, %Review{} = review} <- Commands.UpdateReview.call(form, %{review: review}) do
      render(conn, "show.json", review: review)
    end
  end
end
