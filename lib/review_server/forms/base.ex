defmodule ReviewServer.Forms.Base do
  @moduledoc """
  Every form file should use this module.

  ## Examples
      defmodule Forms.CreateResource
        use ReviewServer.Forms.Base

        # ...
      end
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end
end
