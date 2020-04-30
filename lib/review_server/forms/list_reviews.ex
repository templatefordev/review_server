defmodule Forms.ListReviews do
  @moduledoc false

  use ReviewServer.Forms.Base

  schema "" do
    field :resource_id, Ecto.UUID, virtual: true
    field :owner_id, Ecto.UUID, virtual: true
    field :page, :integer, virtual: true
    field :page_size, :integer, virtual: true
  end

  @optional_fields ~w(page page_size)a

  @doc false
  @spec changeset(any) :: Ecto.Changeset.t()
  def changeset(params) when params == %{} do
    %__MODULE__{}
    |> change(%{})
    |> add_error(:params, "add resource_id or owner_id")
  end

  @doc false
  def changeset(%{"resource_id" => _resource_id, "owner_id" => _owner_id}) do
    %__MODULE__{}
    |> change(%{})
    |> add_error(:params, "only resource_id or owner_id")
  end

  @doc false
  def changeset(%{"resource_id" => _resource_id} = params) do
    %__MODULE__{}
    |> cast(params, [:resource_id] ++ @optional_fields)
    |> validate_required([:resource_id])
  end

  @doc false
  def changeset(%{"owner_id" => _owner_id} = params) do
    %__MODULE__{}
    |> cast(params, [:owner_id] ++ @optional_fields)
    |> validate_required([:owner_id])
  end
end
