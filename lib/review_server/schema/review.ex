defmodule Review do
  @moduledoc false

  use ReviewServer.Schema.Base

  schema "reviews" do
    field :rating, :integer
    field :comment, :string
    field :owner_id, Ecto.UUID

    timestamps()

    belongs_to :resource, ResourceStats, references: :resource_id
  end
end
