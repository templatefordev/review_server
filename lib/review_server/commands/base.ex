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
    end
  end
end
