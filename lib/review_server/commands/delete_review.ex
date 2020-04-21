defmodule Commands.DeleteReview do
  @moduledoc false

  use ReviewServer.Commands.Base

  def call(%{review: review}) do
    Repo.delete(review)
  end

  def call(%{resource_id: resource_id}) do
    Queries.DeleteReviews.call(%{resource_id: resource_id})
    |> Ecto.Query.exclude(:limit)
    |> Ecto.Query.exclude(:order_by)
    |> Repo.delete_all()
  end
end
