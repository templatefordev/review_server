defmodule ReviewServerWeb.ResourceView do
  use ReviewServerWeb, :view

  def render("show.json", %{resource: resource}) do
    %{resource: render_one(resource, __MODULE__, "resource.json")}
  end

  def render("resource.json", %{resource: resource}) do
    %{
      id: resource.resource_id,
      avg_rating: resource.avg_rating,
      count_reviews: resource.count
    }
  end
end
