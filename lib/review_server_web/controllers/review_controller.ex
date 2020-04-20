defmodule ReviewServerWeb.ReviewController do
  use ReviewServerWeb, :controller

  action_fallback ReviewServerWeb.FallbackController

  def index(conn, params) do
    form = Forms.ListReviews.changeset(params)

    case form.valid? do
      true ->
        page = Queries.ListReviews.call(form.changes) |> Repo.paginate(params)
        render(conn, "index.json", reviews: page.entries, meta: build_meta(page))

      false ->
        {:error, form}
    end
  end

  def show(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)
    render(conn, "show.json", review: review)
  end

  def create(conn, %{"review" => review_params}) do
    form = Forms.CreateReview.changeset(review_params)

    with {:ok, %Review{} = review} <- Commands.CreateReview.call(form) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.review_path(conn, :show, review))
      |> render("show.json", review: review)
    end
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Repo.get!(Review, id)
    form = Forms.UpdateReview.changeset(review_params)

    with {:ok, %Review{} = review} <- Commands.UpdateReview.call(form, %{review: review}) do
      render(conn, "show.json", review: review)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Repo.get!(Review, id)

    with {:ok, %Review{}} <- Commands.DeleteReview.call(%{review: review}) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete(conn, %{"resource_id" => resource_id}) do
    _review = Queries.DeleteReviews.call(%{resource_id: resource_id}) |> Repo.one!()

    with {_, nil} <- Commands.DeleteReview.call(%{resource_id: resource_id}) do
      send_resp(conn, :no_content, "")
    end
  end
end
