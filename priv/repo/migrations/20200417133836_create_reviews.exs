defmodule ReviewServer.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :rating, :integer
      add :comment, :text
      add :resource_id, :uuid
      add :owner_id, :uuid

      timestamps()
    end

    create index(:reviews, [:owner_id])
    create index(:reviews, [:resource_id])
    create index(:reviews, [:inserted_at])
  end
end
