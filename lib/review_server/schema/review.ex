defmodule Review do
  @moduledoc false

  use ReviewServer.Schema.Base

  schema "reviews" do
    field :rating, :integer
    field :comment, :string
    field :resource_id, Ecto.UUID
    field :owner_id, Ecto.UUID

    timestamps()
  end
end
