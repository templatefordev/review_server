defmodule Forms.ListReviews do
  @moduledoc false

  use ReviewServer.Forms.Base

  schema "" do
    field :resource_id, Ecto.UUID, virtual: true
    field :page, :integer, virtual: true
    field :page_size, :integer, virtual: true
  end

  @required_fields ~w(resource_id)a
  @optional_fields ~w(page page_size)a

  @doc false
  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
