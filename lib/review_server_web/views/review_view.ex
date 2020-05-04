defmodule ReviewServerWeb.ReviewView do
  use ReviewServerWeb, :view
  import ReviewServer.Utils.Map

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
    r = %{
      id: review.id,
      rating: review.rating,
      comment: review.comment,
      owner_id: review.owner_id,
      inserted_at: DateTime.to_iso8601(review.inserted_at),
      updated_at: DateTime.to_iso8601(review.updated_at)
    }

    if Ecto.assoc_loaded?(review.resource) do
      r ||| render_one(review.resource, ReviewServerWeb.ResourceView, "show.json")
    else
      r ||| %{resource_id: review.resource_id}
    end
  end
end
