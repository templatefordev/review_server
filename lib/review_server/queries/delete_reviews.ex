defmodule Queries.DeleteReviews do
  use ReviewServer.Queries.Base

  defmodule Params do
    defstruct resource_id: nil

    use ExConstructor
  end

  def call(params) do
    params
    |> Params.new()
    |> list_reviews_query()
    |> first()
  end
end
