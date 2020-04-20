defmodule ReviewServer.Commands.Base do
  @moduledoc """
  Every command file should use this module.

  ## Examples
      defmodule Commands.CreateResource
        use ReviewServer.Commands.Base

        # ...
      end
  """

  defmacro __using__(_) do
    quote do
      alias ReviewServer.Repo
      import Ecto.Changeset

      def call(%{valid?: false} = form), do: {:error, form}
      def call(%{valid?: false} = form, _), do: {:error, form}
    end
  end
end
