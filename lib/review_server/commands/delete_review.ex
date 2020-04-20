defmodule Commands.DeleteReview do
  use ReviewServer.Commands.Base

  def call(%{review: review}) do
    Repo.delete(review)
  end
end
