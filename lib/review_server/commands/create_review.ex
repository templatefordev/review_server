defmodule Commands.CreateReview do
  use ReviewServer.Commands.Base

  def call(args) do
    Review
    |> struct(args)
    |> Repo.insert()
  end
end
