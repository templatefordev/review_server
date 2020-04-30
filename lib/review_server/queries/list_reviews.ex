defmodule Queries.ListReviews do
  @moduledoc false

  use ReviewServer.Queries.Base

  defmodule Params do
    @moduledoc false
    defstruct resource_id: nil,
              owner_id: nil,
              page: nil,
              page_size: nil

    use ExConstructor
  end

  @spec call([{atom | binary, any}] | %{optional(atom | binary) => any}) :: Ecto.Query.t()
  def call(params) do
    params
    |> Params.new()
    |> list_reviews_query()
    |> filter_by_owner_id(Params.new(params))
    |> order_by(desc: :inserted_at)
  end

  defp filter_by_owner_id(query, %{owner_id: nil}), do: query

  defp filter_by_owner_id(query, %{owner_id: owner_id}) do
    query |> where(owner_id: ^owner_id)
  end
end
