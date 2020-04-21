defmodule ReviewServer.Factory do
  @moduledoc """
  Provides a function `build/1`, `build/2`, `insert!/1`, `insert!/2`
  to build or insert test data
  """

  alias ReviewServer.Repo

  def build(:review) do
    %Review{
      rating: Enum.random(1..5),
      comment: "some comment #{System.unique_integer([:positive])}",
      resource_id: Ecto.UUID.generate(),
      owner_id: Ecto.UUID.generate()
    }
  end

  @doc """
  ## Examples
      iex> build(:post)
      %MyApp.Post{id: nil, title: "hello world", ...}

      iex> build(:post, title: "custom title")
      %MyApp.Post{id: nil, title: "custom title", ...}
  """
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  @doc """
  ## Examples
      iex> insert!(:post)
      %MyApp.Post{id: ..., title: "hello world", ...}

      iex> insert!(:post, title: "custom title")
      %MyApp.Post{id: ..., title: "custom title"}
  """
  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end
end
