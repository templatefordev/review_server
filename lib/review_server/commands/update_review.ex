defmodule Commands.UpdateReview do
  use ReviewServer.Commands.Base

  def call(%{changes: args}, %{review: %Review{} = review}) do
    review
    |> change(args)
    |> Repo.update()
  end
end
