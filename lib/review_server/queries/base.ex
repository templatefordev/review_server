defmodule ReviewServer.Queries.Base do
  @moduledoc """
  Every query file should use this module.

  ## Examples
      defmodule Queries.ListResource
        use ReviewServer.Queries.Base

        # ...
      end
  """

  defmacro __using__(_) do
    quote do
      import Ecto.Query
      alias ReviewServer.Repo

      defp list_reviews_query(options) do
        from(r in Review)
        |> filter_by_resource_id(options)
      end

      defp filter_by_resource_id(query, %{resource_id: nil}), do: query

      defp filter_by_resource_id(query, %{resource_id: resource_id}) do
        query |> where(resource_id: ^resource_id)
      end
    end
  end
end
