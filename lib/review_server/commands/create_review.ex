defmodule Commands.CreateReview do
  use ReviewServer.Commands.Base

  def call(%{changes: args}) do
    Review
    |> struct(args)
    |> Repo.insert()
  end
end
