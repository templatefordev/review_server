defmodule ReviewServer.Factory do
  alias ReviewServer.Repo

  def build(:review) do
    %Review{
      rating: Enum.random(1..5),
      comment: "some comment #{System.unique_integer([:positive])}",
      resource_id: Ecto.UUID.generate(),
      owner_id: Ecto.UUID.generate()
    }
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end
end
