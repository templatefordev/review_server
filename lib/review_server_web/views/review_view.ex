defmodule ReviewServerWeb.ReviewView do
  use ReviewServerWeb, :view

  def render("index.json", %{reviews: reviews, meta: meta}) do
    %{
      reviews: render_many(reviews, __MODULE__, "review.json"),
      meta: meta
    }
  end

  def render("show.json", %{review: review}) do
    %{review: render_one(review, __MODULE__, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{
      id: review.id,
      rating: review.rating,
      comment: review.comment,
      resource_id: review.resource_id,
      owner_id: review.owner_id,
      inserted_at: DateTime.to_iso8601(review.inserted_at),
      updated_at: DateTime.to_iso8601(review.updated_at)
    }
  end
end
