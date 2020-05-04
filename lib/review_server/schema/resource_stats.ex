defmodule ResourceStats do
  @moduledoc false

  use ReviewServer.Schema.Base

  @primary_key {:resource_id, :binary_id, autogenerate: false}
  schema "resources_v" do
    field :avg_rating, :decimal
    field :count, :integer
  end
end
