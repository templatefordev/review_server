defmodule ReviewServer.Repo.Migrations.AddResourcesView do
  use Ecto.Migration

  def change do
    execute(
      """
      CREATE VIEW resources_v  AS
        SELECT
          resource_id,
          round(avg(rating), 2) AS avg_rating,
          count(id) AS count
        FROM reviews
        GROUP BY resource_id
        ORDER BY avg_rating DESC;
      """,
      "DROP VIEW resources_v;"
    )
  end
end
