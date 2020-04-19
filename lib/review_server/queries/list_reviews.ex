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
    |> Repo.paginate(params)
  end

  def list_reviews_query(options) do
    from(r in Review)
    |> filter_by_resource_id(options)
  end

  defp filter_by_resource_id(query, %Params{resource_id: resource_id}) do
    query |> where(resource_id: ^resource_id)
  end
end
