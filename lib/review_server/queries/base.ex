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
    end
  end
end
