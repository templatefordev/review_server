defmodule Queries.ListReviews do
  use ReviewServer.Queries.Base

  defmodule Params do
    defstruct resource_id: nil,
              page: nil,
              page_size: nil

    use ExConstructor
  end

  def call(params) do
    params
    |> Params.new()
    |> list_reviews_query()
    |> order_by(desc: :inserted_at)
  end
end
