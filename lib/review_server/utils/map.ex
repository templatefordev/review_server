defmodule ReviewServer.Utils.Map do
  @moduledoc false

  @doc """
    ## Examples

      iex> %{a: "123"} ||| %{b: "345"}
      %{a: "123", b: "345"}
  """
  @spec map ||| map :: map
  def a ||| b, do: Map.merge(a, b)
end
