defmodule Queries.DeleteReviews do
  @moduledoc false

  use ReviewServer.Queries.Base

  defmodule Params do
    @moduledoc false
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
