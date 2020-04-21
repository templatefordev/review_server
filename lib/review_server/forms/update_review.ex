defmodule Forms.UpdateReview do
  @moduledoc false

  use ReviewServer.Forms.Base

  schema "" do
    field :rating, :integer, virtual: true
    field :comment, :string, virtual: true
  end

  @required_fields ~w(rating)a
  @optional_fields ~w(comment)a

  @doc false
  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:rating, greater_than: 0, less_than: 6)
  end
end
