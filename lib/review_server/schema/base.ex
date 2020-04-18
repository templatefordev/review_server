defmodule ReviewServer.Schema.Base do
  @moduledoc """
  Every schema file should use this module.

  ## Examples
      defmodule RandomModel
        use ReviewServer.Schema.Base

        # ...
      end
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, read_after_writes: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
